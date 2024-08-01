//
//  RegistrationView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var apiService: ApiService
    @EnvironmentObject var userState: UserState
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isLoading: Bool = false
    @State var error: String = ""
    @State var isValidEmail = false
    @State var showEmailError = false
    @State var showPasswordError = false
    
    var passwordMismatch: Bool {
        !password.isEmpty && !confirmPassword.isEmpty && password != confirmPassword
    }
    
    @MainActor
    private func registerUser() async {
        do {
            error = ""
            isLoading = true
            
            let result = try await apiService.register(payload: RegisterPayload(name: name.lowercased().trimmingCharacters(in: .whitespaces), email: email.lowercased().trimmingCharacters(in: .whitespaces), password: password))
            await userState.updateUserAndJwt(jwt: result.token, user: result.user)
        } catch let error as APIError {
            self.error = error.errorMessage
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    var body: some View {
        ScrollVStack(spacing: 20) {
            Text("label_register".localized())
                .textStyle(.textSecondary, size: 40, weight: .semibold)
            
            VStack(spacing: 30) {
                InputWrapper(label: "label_email".localized(), errorMessage: showEmailError ? "error_please_provide_a_properly_formatted_email".localized() : nil) {
                    EmailTextField(email: $email, isValid: $isValidEmail)
                }
                
                InputWrapper(label: "label_name".localized()) {
                    FRTextField(
                        text: $name,
                        placeholder: "John Doe"
                    )
                }
                
                InputWrapper(label: "label_password".localized(), errorMessage: showPasswordError ? "error_password_must_be_at_least_8_characters_long_contain_a_number_and_an_uppercase_letter".localized() : nil) {
                    PasswordField(password: $password)
                }
                
                InputWrapper(label: "label_confirm_password".localized(), errorMessage: passwordMismatch ? "error_passwords_do_not_match".localized() : nil) {
                    PasswordField(password: $confirmPassword)
                }
            }
            
            if !error.isEmpty {
                ErrorView(error: error, width: .fill)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("button_cancel".localized()) {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.textPrimary)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                FRButton(
                    "label_register".localized(),
                    width: .fit,
                    padding: 12,
                    isLoading: isLoading
                ) {
                    showEmailError = !isValidEmail
                    showPasswordError = !password.isValidPassword
                    if (isValidEmail && password.isValidPassword && !passwordMismatch) {
                        Task {
                            await registerUser()
                        }
                    }
                }
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistrationView()
                .environmentObject(ApiService(nil))
                .environmentObject(UserState())
        }
    }
}
