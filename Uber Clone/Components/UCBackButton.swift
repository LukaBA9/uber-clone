//
//  UCBackButton.swift
//  Uber Clone
//
//  Created by Luka on 19.5.25..
//

import SwiftUI

struct UCBackButton: View {
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrow.backward")
                .padding(3)
        }
        .foregroundStyle(color)

    }
}

#Preview {
    UCBackButton(color: .ucPrimary, action: {})
}
