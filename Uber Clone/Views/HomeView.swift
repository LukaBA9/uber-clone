//
//  HomeView.swift
//  Uber Clone
//
//  Created by Luka on 21.5.25..
//

import SwiftUI
import MapKit

enum ModalDetent {
    case extended, minimized
    
    var presentationDetent: PresentationDetent {
        switch self {
        case .extended:
            return .fraction(0.87)
        case .minimized:
            return .fraction(0.63)
        }
    }
}

struct HomeView: View {
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    @State private var showLocationSearchView: Bool = false
    @State private var showRideRequestView: Bool    = false
    
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .background(.ultraThinMaterial)
                    } else {
                        ZStack(alignment: .bottom) {
                            MapView()
                                .overlay(alignment: .topLeading, content: {
                                    if showRideRequestView {
                                        UCBackButton(color: .ucForeground) {
                                            showRideRequestView = false
                                            locationSearchViewModel.deinitializeRoute()
                                        }
                                        .padding()
                                        .background(Color.ucBackground, in: Circle())
                                        .padding()
                                    }
                                })
                                .sheet(isPresented: $showRideRequestView) {
                                    RideRequestView()
                                        .environmentObject(RideRequestViewModel())
                                        .presentationDetents([ModalDetent.minimized.presentationDetent, ModalDetent.extended.presentationDetent])
                                        .presentationBackgroundInteraction(.enabled)
                                        .interactiveDismissDisabled()
                                        .presentationBackground(.ultraThinMaterial)
                                }
                            NavigationLink {
                                LocationSearchView(showRideRequestView: $showRideRequestView, isLoading: $isLoading)
                                    .navigationTitle("Plan your ride")
                            } label: {
                                CollapsedSearchView {
                                    showLocationSearchView = true
                                }
                            }
                            .padding(.bottom, 50)
                    }
                    .toolbar(.hidden)
                }
            }
            .onAppear() {
                CLLocationManager().requestWhenInUseAuthorization()
            }
            .task {
                await locationSearchViewModel.getUserLocation {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
