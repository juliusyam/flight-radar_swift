//
//  View.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import Foundation
import SwiftUI

extension View {
    func tabConfigs(_ name: String, tag: FRTab, systemImage: String, identifier: String) -> some View {
      tabItem {
        Label(name, systemImage: systemImage)
          .accessibilityIdentifier(identifier)
      }
      .tag(tag)
      .navigationBarTitle(Text(name))
      .navigationWrapper()
    }
    
    func navigationWrapper() -> some View {
      navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
    
}
