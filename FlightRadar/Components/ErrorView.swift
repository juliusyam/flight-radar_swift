//
//  ErrorView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 11/07/2024.
//

import SwiftUI

struct ErrorView: View {
    private let error: String?
    private let icon: Image?
    private let width: ErrorViewWidth
    private let textSize: CGFloat
    
    init(
        error: String? = nil,
        icon: Image? = nil,
        textSize: CGFloat = 16,
        width: ErrorViewWidth = .fit
    ) {
        self.error = error
        self.icon = icon
        self.width = width
        self.textSize = textSize
    }
    
    var body: some View {
        HStack(spacing: 8) {
            if let icon = icon {
                icon
                    .foregroundColor(.redPrimary)
            }
            
            if let errorMessage = error {
                Text(errorMessage)
                    .foregroundColor(.redPrimary)
                    .textStyle(size: textSize, weight: .semibold)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if width == .fill {
                Spacer(minLength: 0)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .frame(maxWidth: width == .fill ? .infinity : nil)
        .background(Color.redPrimary.opacity(0.2))
        .cornerRadius(10)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ErrorView(error: "This is a fit error message", icon: Image(systemName: "exclamationmark.triangle"))
            
            ErrorView(error: "This is a fill error message", icon: Image(systemName: "exclamationmark.triangle"), width: .fill)
            
            ErrorView(error: "This is a long error message that will wrap to multiple lines when it exceeds the available width", icon: Image(systemName: "exclamationmark.triangle"), width: .fill)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
