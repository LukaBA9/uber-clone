//
//  UCBodyLabel.swift
//  Uber Clone
//
//  Created by Luka on 19.5.25..
//

import SwiftUI

struct UCBodyLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
    }
}

#Preview {
    UCBodyLabel(text: "")
}
