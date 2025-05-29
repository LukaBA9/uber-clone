//
//  Extensions.swift
//  Uber Clone
//
//  Created by Luka on 23.5.25..
//


import SwiftUI
import MapKit

extension SheetView {
    var selection: Binding<PresentationDetent> {
        Binding(
            get: { detent.presentationDetent },
            set: { newDetent in
                if newDetent == ModalDetent.minimized.presentationDetent
                    { detent = .minimized }
                else
                    { detent = .extended }
            }
        )
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}

extension Font {
    static var nunitoTitle: Font {
        return Font.custom("Nunito", size: 27).bold()
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Date {
    var formattedDescription: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let time = formatter.string(from: self)
        
        return time
    }
}

extension Double {
    var formattedDescription: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        if let formatterAmount = formatter.string(from: NSNumber(value: self)) {
            return formatterAmount
        }
        return ""
    }
}
