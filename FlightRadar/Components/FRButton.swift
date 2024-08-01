//
//  FRButton.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import SwiftUI

struct FRButton: View {
    private let text: String
    private let action: () -> Void
    private let color: Color
    private let icon: Image?
    private let width: ButtonWidth
    private let padding: CGFloat
    private let alignment: HorizontalAlignment
    private let isLoading: Bool
    
    init(
        _ text: String,
        color: Color = .buttonPrimary,
        icon: Image? = nil,
        width: ButtonWidth = .fit,
        padding: CGFloat = 10,
        alignment: HorizontalAlignment = .center,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.action = action
        self.color = color
        self.icon = icon
        self.width = width
        self.padding = padding
        self.alignment = alignment
        self.isLoading = isLoading
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if alignment == .trailing {
                    Spacer()
                }
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(text)
                }
                
                if alignment == .leading {
                    Spacer()
                }
                
                if let icon = icon, !isLoading {
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
        .disabled(isLoading)
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
            FRButton("normal state",
                     color: .green,
                     padding: 16,
                     alignment: .leading) {
                print("button tapped")
            }
            
            FRButton("loading state",
                     color: .orange,
                     icon: Image(systemName: "star.fill"),
                     width: .fill,
                     padding: 12,
                     alignment: .center,
                     isLoading: true) {
                print("button tapped")
            }
            
            FRButton("Normal state",
                     color: .purple,
                     width: .fixed(200),
                     padding: 20,
                     alignment: .trailing) {
                print("button tapped")
            }
        }
        .padding()
    }
}
