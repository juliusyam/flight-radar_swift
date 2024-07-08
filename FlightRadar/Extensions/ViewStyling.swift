//
//  Gradiant.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 08/07/2024.
//

import Foundation
import SwiftUI

extension View {
    func linearGradientBackground() -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.6, blue: 1.0), Color(red: 0.1, green: 0.3, blue: 0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            self
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func textFieldBackground() -> some View {
        self
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func buttonStyle() -> some View {
        //  TODO: To expand this to accommodate a different set of buttons
        self
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .bold, design: .default))
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func titleStyle() -> some View {
        self
            .font(.system(size: 40, weight: .bold, design: .default))
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
    }

    func subTitleStyle() -> some View {
        self
            .font(.system(size: 18, weight: .semibold, design: .default))
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}
