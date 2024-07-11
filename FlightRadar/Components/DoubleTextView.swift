//
//  DoubleText.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 11/07/2024.
//

import SwiftUI

struct DoubleTextView: View {
    let text: String
    let subText: String
    var isLeftAligned: Bool = false
    
    var body: some View {
        VStack(alignment: isLeftAligned ? .trailing : .leading, spacing: 8) {
            TextView(text: text)
            TextView(text: subText)
        }
    }
    
    private func TextView(text: String) -> some View {
        Text(text)
            .textStyle(.textPrimary, size: 14, weight: .semibold)
    }
    
    func startEnd() -> some View {
        var view = self
        view.isLeftAligned = true
        return view
    }
}

struct DoubleTextView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            DoubleTextView(text: "Hello", subText: "world plus any other worlds")
            
            DoubleTextView(text: "Hello", subText: "world plus any other worlds")
                .startEnd()
            
        }
    }
}

