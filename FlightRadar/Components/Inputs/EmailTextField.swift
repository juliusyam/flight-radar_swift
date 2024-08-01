//
//  EmailTextField.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 23/07/2024.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var email: String
    @Binding var isValid: Bool
    
    var body: some View {
        FRTextField(
            text: $email,
            isValid: $isValid,
            placeholder: "label_email".localized(),
            onValidate: { $0.emailIsValid() }
        )
        .keyboardType(.emailAddress)
        .textContentType(.emailAddress)
        .autocapitalization(.none)
        .disableAutocorrection(true)
    }
}

struct EmailTextField_Previews: PreviewProvider {
    static var previews: some View {
        EmailTextField(email: .constant(""), isValid: .constant(false))
        
        EmailTextField(email: .constant("user@example.com"), isValid: .constant(true))
    }
}
