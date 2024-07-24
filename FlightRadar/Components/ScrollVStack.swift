//
//  ScrollVStack.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 24/07/2024.
//

import SwiftUI

struct ScrollVStack<Content: View>: View {
    let alignment: HorizontalAlignment
    let spacing: CGFloat?
    let content: () -> Content
    let padding: CGFloat
    
    init(
        alignment: HorizontalAlignment = .leading,
        spacing: CGFloat? = 20,
        padding: CGFloat = 15,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
        self.padding = padding
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: alignment, spacing: spacing) {
                content()
            }
            .fillSpacing(padding: padding)
        }
    }
}


struct ScrollVStack_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
