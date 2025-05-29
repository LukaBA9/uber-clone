//
//  LocationSearchResultRowView.swift
//  Uber Clone
//
//  Created by Luka on 21.5.25..
//

import SwiftUI

struct LocationSearchResultRowView: View {
    let title: String
    let subtitle: String
    
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(Color.ucPrimary)
            
            Text(subtitle)
                .foregroundStyle(Color.ucSecondary)
            Divider()
        }
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    LocationSearchResultRowView(title: "", subtitle: "", action: {})
}
