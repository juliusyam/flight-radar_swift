//
//  DropDownView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 10/07/2024.
//

import SwiftUI

struct DropDownView<T: RawRepresentable & CaseIterable>: View where T.RawValue == String {
    @Binding var selected: T
    
    var body: some View {
        Menu {
            ForEach(Array(T.allCases), id: \.rawValue) { option in
                Button(action: {
                    selected = option
                }) {
                    Text(option.rawValue.localized())
                        .fontWeight(option == selected ? .semibold : .regular)
                        .foregroundColor(.textPrimary)
                }
            }
        } label: {
            Text(selected.rawValue)
                .padding(12)
                .background(Color.cardPrimary)
                .foregroundColor(.textPrimary)
                .cornerRadius()
        }
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State private var selectedOption: FlightOption = .all
        
        var body: some View {
            DropDownView(selected: $selectedOption)
        }
    }
}
