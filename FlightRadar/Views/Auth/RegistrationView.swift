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
            Text("Register")
                .textStyle(.textSecondary, size: 40, weight: .semibold)
            
            VStack(spacing: 30) {
                InputWrapper(label: "Email", errorMessage: showEmailError ? "Please provide a properly formatted email" : nil) {
                    EmailTextField(email: $email, isValid: $isValidEmail)
                }
                
                InputWrapper(label: "Name") {
                    FRTextField(
                        text: $name,
                        placeholder: "e.g John Doe"
                    )
                }
                
                InputWrapper(label: "Password", errorMessage: showPasswordError ? "Password must be at least 8 characters long, contain a number and an uppercase letter" : nil) {
                    PasswordField(password: $password)
                }
                
                InputWrapper(label: "Confirm Password", errorMessage: passwordMismatch ? "Passwords do not match" : nil) {
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
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.textPrimary)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                FRButton(
                    "Register",
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
