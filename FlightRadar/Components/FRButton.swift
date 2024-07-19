//
//  FRButton.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import SwiftUI

struct FRButton<Content: View>: View {
    private let action: () -> Void
    private let textView: () -> Content
    private let color: Color
    private let icon: Image?
    private let width: ButtonWidth
    private let padding: CGFloat
    
    init(
        action: @escaping () -> Void,
        color: Color = .button,
        icon: Image? = nil,
        width: ButtonWidth = .fit,
        padding: CGFloat = 10,
        @ViewBuilder textView: @escaping () -> Content
    ) {
        self.action = action
        self.textView = textView
        self.color = color
        self.icon = icon
        self.width = width
        self.padding = padding
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                textView()
                
                if case .fill = width {
                    Spacer()
                }
                
                if let icon = icon {
                    Spacer()
                        .frame(maxWidth: 10)
                    icon
                }
            }
            .padding(padding)
            .frame(maxWidth: buttonWidth)
            .background(color)
            .foregroundColor(.white)
        }
    }
    
    private var buttonWidth: CGFloat? {
        switch width {
        case .fit:
            return nil
        case .fill:
            return .infinity
        case .fixed(let width):
            return width
        }
    }
}

struct FRButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FRButton(
                action: { print("Button tapped") },
                color: .green,
                padding: 16
            ){ Text("Fit width") }
            
            FRButton(
                action: { print("Button tapped") },
                color: .orange,
                icon: Image(systemName: "star.fill"),
                width: .fill,
                padding: 12
            ){ Text("Fill width with icon") }
            
            FRButton(
                action: { print("Button tapped") },
                color: .purple,
                width: .fixed(200),
                padding: 20
            ){ Text("Fixed width (200)") }
        }
        .padding()
    }
}
