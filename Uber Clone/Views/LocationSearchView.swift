//
//  ExpandedModalView.swift
//  Uber Clone
//
//  Created by Luka on 19.5.25..
//

import SwiftUI
import MapKit

struct LocationSearchView: View {
    
    enum InputFieldFocusedState {
        case pickupLocation, destinationLocation
    }
    
//    enum PickupOptions {
//        case now, later
//    }
    @State private var showPickupOptionsSheet: Bool = false
    @State private var pickupLocationText: String = ""
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @Binding var showRideRequestView: Bool
    @Binding var isLoading: Bool
    
    @FocusState private var focusState: LocationSearchViewModel.FocusedField?
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Divider()
            //Pick up now Button
//            DropdownButton(image: "clock.fill", text: "Pickup now")
            
            //Input form
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "location")
                    TextField("Enter pickup location", text: $viewModel.pickupLocationQueryFragment)
                        .focused($focusState, equals: .pickupLocation)
                }
                Divider()
                    .padding(7)
                HStack {
                    Image(systemName: "location.fill")
                    TextField("Where to?", text: $viewModel.destinationLocationQueryFragment)
                        .focused($focusState, equals: .destinationLocation)
                }
            }
            .padding(7)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                    .foregroundStyle(Color.primary)
            }
            
            Divider()
            LocationSearchResultRowView(title: "Pick location on map", subtitle: "") {
                dismiss()
            }
            if focusState != nil {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.results, id: \.self) { location in
                            LocationSearchResultRowView(title: location.title, subtitle: location.subtitle) {
                                viewModel.calculateFocusState(location) {
                                    isLoading = true
                                    showRideRequestView = true
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }
            else if viewModel.isLoading {
                GeometryReader { proxy in
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
            Spacer()

        }
//        .sheet(isPresented: $showPickupOptionsSheet, content: {
//            VStack(alignment: .leading) {
//                HStack {
//                    Text("Pickup now")
//                    Spacer()
//                    Button {
//                        //select now
//                    } label: {
//                        Circle()
//                            .frame(width: 50)
//                            .stroke(lineWidth: 2)
//                            .foregroundStyle(Color.ucPrimary)
//                            .overlay {
//
//                            }
//                    }
//
//                }
//            }
//        })
        .padding()
        .background(BackgroundStyle.background)
        .onChange(of: focusState) { _, _ in
            if focusState == .pickupLocation {
                viewModel.pickupTask?.cancel()
            } else if focusState == .destinationLocation {
                viewModel.destinationTask?.cancel()
            }
        }
        .onChange(of: focusState) { _, newValue in
            viewModel.focusedField = newValue
        }
        .onChange(of: viewModel.focusedField) { _, newValue in
            focusState = newValue
        }
    }
}

#Preview {
    LocationSearchView(showRideRequestView: .constant(false), isLoading: .constant(false))
}
