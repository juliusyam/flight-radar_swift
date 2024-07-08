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
        VStack {
            Button(action: {
                Task {
                 await userState.removeUserAndJWT()
                }
            }) {
                Text("Logout")
                    .padding()
                    .buttonStyle()
            }
        }
        .padding(.horizontal, 20)
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

