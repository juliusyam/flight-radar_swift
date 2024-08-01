//
//  FRTextField.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 18/07/2024.
//

import SwiftUI

struct FRTextField: View {
    @Binding var text: String
    @Binding var isValid: Bool
    let placeholder: String
    let icon: Image?
    let iconPosition: IconPosition
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
        self.icon = nil
        self.iconPosition = .left
        self.onValidate = onValidate
    }
    
    init(
        text: Binding<String>,
        isValid: Binding<Bool> = .constant(true),
        placeholder: String = "",
        icon: Image,
        iconPosition: IconPosition = .left,
        onValidate: ((String) -> Bool)? = nil
    ) {
        self._text = text
        self._isValid = isValid
        self.placeholder = placeholder
        self.icon = icon
        self.iconPosition = iconPosition
        self.onValidate = onValidate
    }
    
    var body: some View {
        HStack(spacing: 10) {
            if iconPosition == .left, let icon = icon {
                icon.foregroundColor(.gray)
            }
            
            TextField(placeholder, text: $text)
            
            if iconPosition == .right, let icon = icon {
                icon.foregroundColor(.gray)
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

struct FRTextComponents_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            FRTextField(text: .constant(""),
                        placeholder: "enter text")
            
            FRTextField(text: .constant(""),
                        placeholder: "with left icon",
                        icon: Image(systemName: "magnifyingglass"))
            
            FRTextField(text: .constant(""),
                        placeholder: "with right icon",
                        icon: Image(systemName: "xmark.circle.fill"),
                        iconPosition: .right)
        }
        .padding()
    }
}
