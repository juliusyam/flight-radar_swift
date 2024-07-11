//
//  TravelIndicatorView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 11/07/2024.
//

import SwiftUI

struct TravelIndicatorView: View {
    var time: String = ""
    var origin: String = ""
    var destination: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                FRDivider()
                    .color(.textPrimary)
                    .dashRate(100)
                
                Spacer()
                    .frame(height: 25)
            }
                
            HStack {
                TagView(text: origin)
                Spacer()
                TextIconView(icon: Image(systemName: "airplane"), text: time)
                    .iconRotation(.degrees(320))
                Spacer()
                TagView(text: destination)
                
            }
            .background(.clear)
        }
    }
}

#Preview {
    TravelIndicatorView(time: "3h:40", origin: "LGW", destination: "JTC")
}
