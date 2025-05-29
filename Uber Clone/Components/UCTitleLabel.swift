//
//  UCTitleLabel.swift
//  Uber Clone
//
//  Created by Luka on 19.5.25..
//

import SwiftUI

struct UCTitleLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.nunitoTitle)
    }
}

#Preview {
    UCTitleLabel(text: "")
}
