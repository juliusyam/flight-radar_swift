//
//  InputWrapper.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 22/07/2024.
//

import SwiftUI

struct InputWrapper<InputView: View>: View {
    private let label: String
    private let inputView: InputView
    private let errorMessage: String?
    
    init(
        label: String,
        errorMessage: String? = nil,
        @ViewBuilder inputView: () -> InputView
    ) {
        self.label = label
        self.errorMessage = errorMessage
        self.inputView = inputView()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(label)
                .textStyle()
            
            inputView
            
            if let errorMessage = errorMessage, !errorMessage.isEmpty {
                ErrorView(error: errorMessage, icon: Image(systemName: "exclamationmark.brakesignal"), width: .fill)
            }
        }
    }
}

struct InputWrapper_Previews: PreviewProvider {
    static var previews: some View {
        InputWrapper(label: "Text", errorMessage: "error") {
            PasswordField(password: .constant("password"))
        }
    }
}
