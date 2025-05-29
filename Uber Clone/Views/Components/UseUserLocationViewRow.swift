//
//  PickupLocationViewRow.swift
//  Uber Clone
//
//  Created by Luka on 22.5.25..
//

import SwiftUI

struct UseUserLocationViewRow: View {
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @Binding var expandSheet: Bool
    var body: some View {
        LocationSearchResultRowView(title: "Use current location", subtitle: "") {
            Task {
                if viewModel.selectedPickupLocation == nil {
                    //update pickup location
                    viewModel.selectedPickupLocation = viewModel.currentLocation
                }
                else {
                    
                }
            }
        }
    }
}

#Preview {
    UseUserLocationViewRow(expandSheet: .constant(false))
}
