//
//  FlightRadarApp.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import SwiftUI

@main
struct FlightRadarApp: App {
    @StateObject private var userState = UserState()
    
    var apiService: ApiService {
        ApiService(userState.jwt)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(apiService)
                .environmentObject(userState)
        }
    }
}
