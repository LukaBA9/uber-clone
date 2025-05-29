//
//  SheetView.swift
//  Uber Clone
//
//  Created by Luka on 23.5.25..
//


import SwiftUI

struct SheetView<Content: View>: View {
    let content: Content
    @Binding var detent: ModalDetent
    
    init(detent: Binding<ModalDetent>, @ViewBuilder content: @escaping () -> Content) {
        self._detent = detent
        self.content = content()
    }
    
    var body: some View {
        content
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.enabled(upThrough: ModalDetent.minimized.presentationDetent))
            .presentationDetents([ModalDetent.minimized.presentationDetent, ModalDetent.extended.presentationDetent], selection: selection)
    }
}