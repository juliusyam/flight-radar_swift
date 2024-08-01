//
//  PasswordField.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 23/07/2024.
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    @State private var isPasswordValid = true
    
    var body: some View {
        FRSecureField(
            text: $password,
            isValid: $isPasswordValid,
            placeholder: "label_enter_your_password".localized(),
            onValidate: { input in
                return !input.isEmpty
            }
        )
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordField(password: .constant(""))
            .padding()
    }
}
