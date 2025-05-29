//
//  Uber.swift
//  Uber Clone
//
//  Created by Luka on 24.5.25..
//

import Foundation

struct Uber: Identifiable {
    let name: String
    let price: Double
    let image: String
    
    var id: String { return name }
}
