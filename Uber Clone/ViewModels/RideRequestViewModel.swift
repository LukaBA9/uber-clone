//
//  RideRequestViewMode.swift
//  Uber Clone
//
//  Created by Luka on 24.5.25..
//

import Foundation

enum Rides: String {
    case uberx = "Uber X", uberxl = "Uber XL", uberBlack = "Uber Black"
    
    var name: String { return self.rawValue }
}

class RideRequestViewModel: ObservableObject {
    let availableRides: [Uber] = [
        .init(name: Rides.uberx.name, price: 20.00, image: "uber-x"),
        .init(name: Rides.uberBlack.name, price: 25.00, image: "uber-black"),
        .init(name: Rides.uberxl.name, price: 30.00, image: "uber-x")
    ]
    
    @Published var selectedRideOption: Rides = .uberx
}
