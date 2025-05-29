//
//  Location.swift
//  Uber Clone
//
//  Created by Luka on 22.5.25..
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String?
    
    var id: String {
        return "\(coordinate.latitude)\(coordinate.longitude)"
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
