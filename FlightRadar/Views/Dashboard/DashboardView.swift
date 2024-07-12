//
//  DashboardView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var userState: UserState
    
    var body: some View {
        ZStack {
            TabView {
                NavigationView {
                  
                }
                .tabConfigs("Dashboard", tag: .dashboard, systemImage: "house", identifier: "dashboard")
                
                NavigationView {
                  FlightsView()
                }
                .tabConfigs("Flights", tag: .flights, systemImage: "airplane", identifier: "flights")
                
                NavigationView {
                  SettingsView()
                }
                .tabConfigs("Settings", tag: .dashboard, systemImage: "gearshape", identifier: "settings")
            }
            .accentColor(.gold)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DashboardView()
                .environmentObject(ApiService(nil))
                .environmentObject(UserState())
        }
    }
}

