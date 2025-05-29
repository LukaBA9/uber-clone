//
//  Button.swift
//  Uber Clone
//
//  Created by Luka on 19.5.25..
//

import SwiftUI

struct UCButton: View {
    let buttonTitle: String
    let fillColor: Color
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonTitle)
                .foregroundStyle(.primary)
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 9)
                        .foregroundStyle(fillColor)
                )
        }

    }
}

#Preview {
    UCButton(buttonTitle: "Placeholder", fillColor: .accentColor, action: {})
}
