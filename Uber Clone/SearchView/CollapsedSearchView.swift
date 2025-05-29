//
//  CollapsedSearchView.swift
//  Uber Clone
//
//  Created by Luka on 21.5.25..
//

import SwiftUI

struct CollapsedSearchView: View {
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    let action: () -> Void
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "location.fill")
            Text(locationSearchViewModel.routeInitalized ? locationSearchViewModel.selectedDestinationLocation!.title : "Where to?")
            Spacer()
        }
        .foregroundStyle(Color.ucPrimary)
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10)
        .padding()
    }
}

#Preview {
    CollapsedSearchView(action: {})
}
