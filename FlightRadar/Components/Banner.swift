//
//  Banner.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 19/07/2024.
//

import SwiftUI

struct Banner: View {
    private let image: Image
    private let text: String?
    private let textAlignment: Alignment
    private let width: CGFloat?
    private let height: CGFloat
    
    init(
        image: Image,
        text: String? = nil,
        textAlignment: Alignment = .center,
        width: CGFloat? = nil,
        height: CGFloat = 200
    ) {
        self.image = image
        self.text = text
        self.textAlignment = textAlignment
        self.width = width
        self.height = height
    }
    
    var body: some View {
        ZStack(alignment: textAlignment) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: height)
                .clipped()
                .overlay {
                    Color.blueSecondary.opacity(0.5)
                }
            
            if let text = text {
                Text(text)
                    .textStyle(.white, size: 30, weight: .bold)
                    .padding(10)
            }
        }
        .frame(width: width, height: height)
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Banner(
                image: Image("exampleImage"),
                text: "Default (Full Width)",
                textAlignment: .topLeading
            )
            
            Banner(
                image: Image("exampleImage"),
                text: "Custom Size",
                width: 300,
                height: 150
            )
            
            Banner(
                image: Image("exampleImage"),
                text: "Custom Width",
                textAlignment: .bottomTrailing,
                width: 250
            )
            
            Banner(
                image: Image("exampleImage"),
                text: "Custom Height",
                height: 100
            )
        }
        .padding()
    }
}
