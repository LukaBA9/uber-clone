//
//  DeliveryAddressViewModel.swift
//  Uber Clone
//
//  Created by Luka on 21.5.25..
//

import Foundation
import MapKit
import SwiftUI
import Combine

class LocationSearchViewModel: NSObject, ObservableObject {
    
    enum FocusedField: Hashable {
        case pickupLocation, destinationLocation
    }
    
    @Published var results                   = [MKLocalSearchCompletion]()
    private let searchCompleter              = MKLocalSearchCompleter()
    
    @Published var selectedPickupLocation: Location?      = nil
    @Published var selectedDestinationLocation: Location? = nil
    @Published var route: MKRoute?                        = nil
    
    @Published var currentLocation: Location?             = nil
    @Published var savedLocations: [SavedLocation]        = []
    
    @Published var destinationLocationQueryFragment: String     = ""
    @Published var pickupLocationQueryFragment: String          = ""
    
    @Published var region: MKCoordinateRegion?       = nil
    
    @Published var pickupTask: Task<Void, Never>?      = nil
    @Published var destinationTask: Task<Void, Never>? = nil
    
    @Published var isLoading: Bool = false
    
    @Published var focusedField: FocusedField? = nil
    
    private var cancellables               = Set<AnyCancellable>()
    let fetchService: CoreDataFetchService = CoreDataFetchService()
    
    private var userRegionCoordinate: CLLocationCoordinate2D?
    
    var routeInitalized: Bool {
        return selectedPickupLocation != nil && selectedDestinationLocation != nil
    }
    
    override init() {
        super.init()
        savedLocations     = fetchService.fetchData()
        searchCompleter.delegate = self
        
        subscribeFieldTexts()
    }
    
    private func subscribeFieldTexts() {
        $pickupLocationQueryFragment
            .debounce(for: .milliseconds(180), scheduler: RunLoop.main)
            .sink { [weak self] fragment in
                guard let self = self else { return }
                
                self.searchCompleter.queryFragment = fragment
                
                if fragment.isEmpty { self.selectedPickupLocation = nil }
            }
            .store(in: &cancellables)
        
        $destinationLocationQueryFragment
            .debounce(for: .milliseconds(180), scheduler: RunLoop.main)
            .sink { [weak self] fragment in
                guard let self = self else { return }
                
                self.searchCompleter.queryFragment = fragment
                
                if fragment.isEmpty { self.selectedDestinationLocation = nil }
            }
            .store(in: &cancellables)
    }
    
    func selectPickupLocationAsync(_ location: MKLocalSearchCompletion, completion: @escaping () -> Void) async throws {
        do {
            if let item = try await locationSearchAsync(for: location) {
                try await MainActor.run {
                    try Task.checkCancellation()
                    self.selectedPickupLocation      = Location(
                                                        coordinate: item.placemark.coordinate,
                                                        title: item.placemark.title ?? "Uknown",
                                                        subtitle: item.placemark.subtitle ?? "")
                    
                    self.pickupLocationQueryFragment = item.placemark.title ?? ""
                }
                
                if routeInitalized {
                    //generate route if both are selected
                    await self.getDirections()
                    await MainActor.run {
                        completion()
                    }
                }
            }
        } catch let error as CancellationError {
            print("Production: Task 1 was cancelled")
            throw error
        } catch {
            print("DEBUG: Error selecting pickup location")
            return
        }
    }
    
    func selectDestinationLocationAsync(_ location: MKLocalSearchCompletion, completion: @escaping () -> Void) async throws {
        do {
            if let item = try await locationSearchAsync(for: location) {
                try await MainActor.run {
                    try Task.checkCancellation()
                    self.selectedDestinationLocation      = Location(
                                                                coordinate: item.placemark.coordinate,
                                                                title: item.placemark.title ?? "Uknown",
                                                                subtitle: item.placemark.subtitle ?? "")
                    
                    self.destinationLocationQueryFragment = item.placemark.title ?? ""
                }
                
                if routeInitalized {
                    //generate route if both are selected
                    await self.getDirections()
                    await MainActor.run {
                        completion()
                    }
                }
            }
        } catch let error as CancellationError {
            print("Production: Task 2 was cancelled")
            throw error
        } catch {
            print("DEBUG: Error selecting destination location")
            return
        }
    }
    
    func locationSearchAsync(for completion: MKLocalSearchCompletion) async throws -> MKMapItem? {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = completion.title.appending(completion.subtitle)
        
        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        
        return response.mapItems.first
    }
    
    func locationSearch(for localSearchCompletion: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let request                  = MKLocalSearch.Request()
        request.naturalLanguageQuery = localSearchCompletion.title.appending(localSearchCompletion.subtitle)
        let search                   = MKLocalSearch(request: request)
        
        search.start(completionHandler: completion)
    }
    
    func getUserLocation(completion: @escaping () -> Void) async {
        let updates = CLLocationUpdate.liveUpdates()
        do {
            let update         = try await updates.first { $0.location?.coordinate != nil }
            guard let location = update?.location else { return }
            let userLocation   = Location(coordinate: location.coordinate, title: "Current location")
            await MainActor.run {
                currentLocation = userLocation
                completion()
            }
        } catch {
            print("DEBUG: Cannot get user location")
            return
        }
    }
    
    func getDirections() async {
        guard let pickupLocation      = selectedPickupLocation,
              let destinationLocation = selectedDestinationLocation else { return }
        
        let request           = MKDirections.Request()
        request.source        = MKMapItem(placemark: .init(coordinate: pickupLocation.coordinate))
        request.destination   = MKMapItem(placemark: .init(coordinate: destinationLocation.coordinate))
        request.transportType = .automobile
        
        do {
            let directions = try await MKDirections(request: request).calculate()
            await MainActor.run {
                self.route = directions.routes.first
            }
        } catch {
            print("Show ERROR")
        }
    }
    
    func deinitializeRoute() {
        self.selectedPickupLocation           = nil
        self.selectedDestinationLocation      = nil
        self.route = nil
    }
    
    func getEstimatedArrivalTime(pickupTime: TimeInterval) -> Date? {
        guard let route = route else { return nil }
        let time = route.expectedTravelTime + pickupTime
        return Date(timeIntervalSince1970: time)
    }
    
    func getRegionFromRoute() -> MKCoordinateRegion? {
        guard let pickupLocation      = selectedPickupLocation,
              let destinationLocation = selectedDestinationLocation
        else { return nil }
        
        let middleLatitude  = (pickupLocation.coordinate.latitude + destinationLocation.coordinate.latitude) / 2
        let middleLongitude = (pickupLocation.coordinate.longitude + destinationLocation.coordinate.longitude) / 2
        
        let latitudeDelta  = abs(pickupLocation.coordinate.latitude - destinationLocation.coordinate.latitude) * 1.4
        let longitudeDelta = abs(pickupLocation.coordinate.longitude - destinationLocation.coordinate.longitude) * 1.4
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: middleLatitude,
                longitude: middleLongitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: latitudeDelta,
                longitudeDelta: longitudeDelta
            )
        )
        
        return region
    }
    
    func getRegionFromCurrentPosition() -> MKCoordinateRegion?{
        guard let currentLocation = self.currentLocation else { return nil }
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: currentLocation.coordinate.latitude,
                longitude: currentLocation.coordinate.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.2,
                longitudeDelta: 0.2
            )
        )
        
        return region
    }
    
    func getRegion() -> MKCoordinateRegion? {
        guard let region = routeInitalized ? getRegionFromRoute() : getRegionFromCurrentPosition() else { return nil }
        return region
    }
    
    
    func calculateFocusState(_ location: MKLocalSearchCompletion, completion: @escaping () -> Void) {
        
        //THE LOCATION WAS SELECTED
        
        //start the process of selecting location
        //swap the focus state
        //if the client has selected the other location before the first one finished, wait until the first one is done, and then update the UI
        pickupTask?.cancel()
        destinationTask?.cancel()
        if focusedField == .pickupLocation {
            pickupTask = Task {
                await MainActor.run {
                    isLoading = true
                    focusedField = nil
                }
                
                do {
                    try Task.checkCancellation()
                    try await selectPickupLocationAsync(location) {
                        self.isLoading = false
                    }
                    await MainActor.run {
                        isLoading = false
                        if selectedDestinationLocation == nil {
                            focusedField = .destinationLocation
                        }
                        else {
                            completion()
                        }
                    }
                } catch {
                    await MainActor.run {
                        deinitializeRoute()
                    }
                    return
                }
            }
        }
        else if focusedField == .destinationLocation {
            destinationTask = Task {
                do {
                    await MainActor.run {
                        isLoading = true
                        focusedField = nil
                    }
                    
                    try Task.checkCancellation()
                    try await selectDestinationLocationAsync(location) {
                        self.isLoading = false
                    }
                    await MainActor.run {
                        isLoading = false
                        if selectedPickupLocation == nil {
                            focusedField = .pickupLocation
                        }
                        else {
                            completion()
                        }
                    }
                } catch {
                    await MainActor.run {
                        deinitializeRoute()
                    }
                    return
                }
            }
        }
    }
}
