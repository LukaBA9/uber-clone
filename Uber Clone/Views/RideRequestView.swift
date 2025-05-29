//
//  RideRequestView.swift
//  Uber Clone
//
//  Created by Luka on 23.5.25..
//

import SwiftUI

struct RideRequestView: View {
    
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @EnvironmentObject var viewModel: RideRequestViewModel
    
    var body: some View {
        VStack {
            //trip info view
            HStack {
                VStack(alignment: .leading) {
                    Text(locationSearchViewModel.selectedPickupLocation?.title ?? "")
                        .clipped()
                    Text(locationSearchViewModel.selectedDestinationLocation?.title ?? "")
                        .clipped()
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text(getEstimatedPickupTime().formattedDescription)
                    Text(locationSearchViewModel.getEstimatedArrivalTime(pickupTime: getEstimatedPickupTime().timeIntervalSince1970)?.formattedDescription ?? "Can't estimate arrival time right now.")
                }
            }
            .padding(.top)
            
            Divider()
            
            //ride type selection view
            
            Text("SUGGESTED RIDES")
                .foregroundStyle(.ucSecondary)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.availableRides) { ride in
                        RideInfoCardView(uber: ride)
                    }
                }
            }
            
            //payment option view
            HStack(spacing: 12) {
                Text("Visa")
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 4))
                    .foregroundStyle(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(.ucSecondary, in: RoundedRectangle(cornerRadius: 10))
            
            // confirm ride button
            UCButton(buttonTitle: "CONFIRM RIDE", fillColor: .accentColor) {
                print("Ride Confirmed")
            }
            Spacer()
        }
        .padding()
    }
    
    private func getEstimatedPickupTime() -> Date {
        return Date().addingTimeInterval(300)
    }
}

#Preview {
    RideRequestView()
}
