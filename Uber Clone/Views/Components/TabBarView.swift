//
//  TabBarView.swift
//  Uber Clone
//
//  Created by Luka on 21.5.25..
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var searchViewModel: LocationSearchViewModel
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Activity", systemImage: "chart.bar.fill") {
                Color.blue
            }
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(LocationSearchViewModel())
}
