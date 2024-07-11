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
    
    var body: some View {
        VStack(spacing: 0) {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 21, height: 21)
                .rotationEffect(iconRotation)
                .foregroundColor(.button)
            
            Text(text)
                .textStyle(.textPrimary, size: 20, weight: .semibold)
                .multilineTextAlignment(.center)
        }
    }
    
    func iconRotation(_ angle: Angle) -> Self {
        var view = self
        view.iconRotation = angle
        return view
    }
}

#Preview {
    TextIconView(icon: Image(systemName: "airplane"), text: "text")
}
