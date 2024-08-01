//
//  FRSecureField.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 23/07/2024.
//

import SwiftUI

struct FRSecureField: View {
    @Binding var text: String
    @Binding var isValid: Bool
    @State private var isRevealed = false
    let placeholder: String
    let onValidate: ((String) -> Bool)?
    
    init(
        text: Binding<String>,
        isValid: Binding<Bool> = .constant(true),
        placeholder: String = "",
        onValidate: ((String) -> Bool)? = nil
    ) {
        self._text = text
        self._isValid = isValid
        self.placeholder = placeholder
        self.onValidate = onValidate
    }
    
    var body: some View {
        HStack(spacing: 10) {
            
            if isRevealed {
                TextField(placeholder, text: $text)
            } else {
                SecureField(placeholder, text: $text)
            }
            
            Button(action: {
                isRevealed.toggle()
            }) {
                Image(systemName: isRevealed ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
            }
        }
        .frTextFieldStyle()
        .onChange(of: text) { newValue in
            if let onValidate = onValidate {
                isValid = onValidate(newValue)
            }
        }
    }
}

struct FRSecureField_Previews: PreviewProvider {
    static var previews: some View {
        FRSecureField(text: .constant(""),
                      placeholder: "enter password")
        
        FRSecureField(text: .constant(""),
                      placeholder: "password with left icon")
    }
}
