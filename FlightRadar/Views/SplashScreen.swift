//
//  SplashScreen.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        
        VStack(spacing: 20) {
            Image(systemName: "airplane")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            Text("Flight Radar")
                .titleStyle()
            
            Text("Track flights in real-time")
                .subTitleStyle()
        }
        .linearGradientBackground()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
