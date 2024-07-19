//
//  ErrorView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 11/07/2024.
//

import SwiftUI

struct ErrorView: View {
    var error: String?
    
    var body: some View {
        Group {
            if let errorMessage = error {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ErrorView(error: "This is an error message")
            ErrorView(error: nil)
            Text("Other content")
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}
