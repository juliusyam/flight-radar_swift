//
//  ErrorView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 11/07/2024.
//

import SwiftUI

struct ErrorView: View {
    var error: String
    
    var body: some View {
        Text(error)
            .foregroundColor(.red)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
    }
}

#Preview {
    ErrorView(error: "Error")
}
