//
//  Uber_CloneApp.swift
//  Uber Clone
//
//  Created by Luka on 19.5.25..
//

import SwiftUI

@main
struct Uber_CloneApp: App {

    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
                .environment(\.font, Font.custom("Nunito", size: 14))
        }
    }
}
