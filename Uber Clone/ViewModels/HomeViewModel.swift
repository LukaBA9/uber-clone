//
//  HomeViewModel.swift
//  Uber Clone
//
//  Created by Luka on 21.5.25..
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    let fetchService: CoreDataFetchService = CoreDataFetchService()
    @Published var savedLocations: [SavedLocation] = []
    
    init() {
        savedLocations = fetchService.fetchData()
    }
}
