//
//  TextIconView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 11/07/2024.
//

import SwiftUI

struct TextIconView: View {
    let icon: Image
    let text: String
    var iconRotation: Angle = .zero
    var iconPosition: IconPosition = .left
    
    enum IconPosition {
        case left, right
    }
    
    var body: some View {
        HStack(spacing: 8) {
            if iconPosition == .left {
                iconView
            }
            
            Text(text)
                .textStyle(.textPrimary, size: 20, weight: .semibold)
                .multilineTextAlignment(.center)
            
            if iconPosition == .right {
                iconView
            }
        }
    }
    
    private var iconView: some View {
        icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 21, height: 21)
            .rotationEffect(iconRotation)
            .foregroundColor(.buttonPrimary)
    }
    
    func iconRotation(_ angle: Angle) -> Self {
        var view = self
        view.iconRotation = angle
        return view
    }
    
    func iconPosition(_ position: IconPosition) -> Self {
        var view = self
        view.iconPosition = position
        return view
    }
}

struct TextIconView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            TextIconView(icon: Image(systemName: "airplane"), text: "Left Icon")
            
            TextIconView(icon: Image(systemName: "airplane"), text: "Right Icon")
                .iconPosition(.right)
            
            TextIconView(icon: Image(systemName: "airplane"), text: "Rotated Icon")
                .iconRotation(.degrees(45))
        }
    }
}
