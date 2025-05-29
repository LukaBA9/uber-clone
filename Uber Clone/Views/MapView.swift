//
//  MapView.swift
//  Uber Clone
//
//  Created by Luka on 21.5.25..
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $cameraPosition) {
            if let selectedPickupLocation = locationSearchViewModel.selectedPickupLocation {
                Marker("Selected Pickup Location", coordinate: selectedPickupLocation.coordinate)
            }
            if let selectedDestinationLocation = locationSearchViewModel.selectedDestinationLocation {
                Marker("Selected Destination Location", coordinate: selectedDestinationLocation.coordinate)
            }
            UserAnnotation()
            
            if let route = locationSearchViewModel.route {
                MapPolyline(route)
                    .stroke(Color.accentColor, lineWidth: 4)
            }
            
            if locationSearchViewModel.selectedPickupLocation != nil && locationSearchViewModel.selectedDestinationLocation != nil {
                MapPolyline(coordinates: [locationSearchViewModel.selectedPickupLocation!.coordinate, locationSearchViewModel.selectedDestinationLocation!.coordinate])
            }
        }
        .onAppear() {
            guard let region = locationSearchViewModel.getRegion() else { return }
            
            withAnimation {
                self.cameraPosition = .region(region)
            }
        }
        .onChange(of: [locationSearchViewModel.selectedPickupLocation,
                       locationSearchViewModel.selectedDestinationLocation]) { _, _ in
            guard let region = locationSearchViewModel.getRegion() else { return }
            
            withAnimation {
                self.cameraPosition = .region(region)
            }
        }
    }
}

#Preview {
    MapView()
}
