//
//  TagView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 11/07/2024.
//

import SwiftUI

struct TagView: View {
    var text: String = ""
    
    var body: some View {
        Text(text)
            .textStyle(size: 16, weight: .semibold)
            .padding(18)
            .background(Color.cardSecondary)
            .cornerRadius(corners: [.allCorners])
    }
}

#Preview {
    TagView(text: "htc")
}
