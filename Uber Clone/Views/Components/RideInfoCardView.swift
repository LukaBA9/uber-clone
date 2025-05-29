//
//  RideInfoCard.swift
//  Uber Clone
//
//  Created by Luka on 24.5.25..
//

import SwiftUI

struct RideInfoCardView: View {
    
    @EnvironmentObject var rideRequestViewModel: RideRequestViewModel
    
    let uber: Uber
    
    var body: some View {
        Button {
            //We are sure that there won't be conflicting names!
            withAnimation {
                rideRequestViewModel.selectedRideOption = Rides(rawValue: uber.id)!
            }
        } label: {
            VStack {
                Image(uber.image)
                    .resizable()
                    .scaledToFit()
                VStack(alignment: .leading) {
                    Text(uber.name)
                    Text("$\(uber.price.formattedDescription)")
                }
            }
            .foregroundStyle(.ucPrimary)
            .frame(width: 112, height: 140)
            .padding()
            .background(rideRequestViewModel.selectedRideOption.name == uber.name ? Color.accentColor : Color.ucSecondary, in: RoundedRectangle(cornerRadius: 9))
        }

    }
}
