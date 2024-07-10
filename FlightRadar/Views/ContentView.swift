//
//  ContentView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var userState: UserState
    @State private var showSplashScreen = true
    
    var body: some View {
        Group {
            if showSplashScreen {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                if userState.user != nil {
                    NavigationView {
                        DashboardView()
                    }
                    .accentColor(.white)
                } else {
                    NavigationView {
                        LoginView()
                    }
                    .accentColor(.white)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ApiService(nil))
            .environmentObject(UserState())
    }
}
