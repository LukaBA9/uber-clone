//
//  DropdownButton.swift
//  Uber Clone
//
//  Created by Luka on 23.5.25..
//


import SwiftUI

struct DropdownButton: View {
    let image: String
    let text: String
    var body: some View {
        Button {
            //show sheet
        } label: {
            HStack {
                Image(systemName: image)
                Text(text)
                Image(systemName: "chevron.down")
            }
        }
        .foregroundStyle(Color.ucPrimary)
        .padding(7)
        .background(.secondary.opacity(0.42), in: Capsule())
    }
}
