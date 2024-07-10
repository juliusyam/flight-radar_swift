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
            .font(.customFont(weight: .bold))
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func titleStyle(_ color: Color = .white) -> some View {
        self
            .font(.customFont(size: 40, weight: .bold))
            .foregroundColor(color)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
    }

    func subTitleStyle(_ color: Color = .white) -> some View {
        self
            .font(.customFont(weight: .semibold))
            .foregroundColor(color)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
    
    func cornerRadius(_ radius: CGFloat = 8, corners: UIRectCorner) -> some View {
         clipShape(RoundedCornerView(radius: radius, corners: corners))
     }
    
    func fillSpacing(padding: CGFloat = 10) -> some View {
        self.padding(padding)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    func fillHorizontal(padding: CGFloat = 10, alignment: Alignment = .topLeading) -> some View {
        self.padding(padding)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func fillVertical(padding: CGFloat = 10, alignment: Alignment = .topLeading) -> some View {
        self.padding(padding)
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

extension Font {
    static func customFont(size: CGFloat = 18, weight: Font.Weight = .regular) -> Font {
            return Font.custom("manrope", size: size).weight(weight)
        }
}
