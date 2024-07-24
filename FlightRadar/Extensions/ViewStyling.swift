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
            .cornerRadius(radius: 10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func buttonStyle() -> some View {
        //  TODO: To expand this to accommodate a different set of buttons
        self
            .foregroundColor(.white)
            .font(.customFont(weight: .bold))
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(radius: 10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func titleStyle(_ color: Color = .white) -> some View {
        self
            .textStyle(color, size: 40, weight: .bold)
    }
    
    func subTitleStyle(_ color: Color = .white) -> some View {
        self
            .textStyle(color)
    }
    
    func textStyle(_ color: Color = .textPrimary, size: CGFloat = 18, weight: Font.Weight = .regular) -> some View {
        self
            .font(.customFont(size: size, weight: .semibold))
            .foregroundColor(color)
    }
    
    func cornerRadius(radius: CGFloat = 8, corners: UIRectCorner = [.allCorners]) -> some View {
        clipShape(RoundedCornerView(radius: radius, corners: corners))
    }
    
    func fillSpacing(padding: CGFloat = 10, alignment: Alignment = .topLeading) -> some View {
        self.padding(padding)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    func fillHorizontal(padding: CGFloat = 10, alignment: Alignment = .topLeading) -> some View {
        self.padding(padding)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func fillVertical(padding: CGFloat = 10, alignment: Alignment = .topLeading) -> some View {
        self.padding(padding)
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func frTextFieldStyle() -> some View {
        self.modifier(
            FRTextFieldStyle()
        )
    }
}

private struct FRTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, minHeight: 49)
            .background(.cardPrimary)
            .cornerRadius(8)
    }
}

extension Font {
    static func customFont(size: CGFloat = 18, weight: Font.Weight = .regular) -> Font {
        return Font.custom("manrope", size: size).weight(weight)
    }
}
