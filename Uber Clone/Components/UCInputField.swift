//
//  UCInputField.swift
//  Uber Clone
//
//  Created by Luka on 19.5.25..
//

import SwiftUI

struct UCInputField: View {
    @Binding var text: String
    var body: some View {
        TextField("Where to?", text: $text)
            .padding()
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    UCInputField(text: .constant(""))
}
