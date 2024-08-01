//
//  SettingsView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var userState: UserState
    
    var body: some View {
        VStack {
            Button(action: {
                Task {
                 await userState.removeUserAndJWT()
                }
            }) {
                Text("button_logout".localized())
                    .padding()
                    .buttonStyle()
            }
        }
        .padding(.horizontal, 20)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .environmentObject(UserState())
        }
    }
}
