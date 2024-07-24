//
//  LoginView.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var apiService: ApiService
    @EnvironmentObject var userState: UserState
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isLoading: Bool = false
    @State var error: String = ""
    @State var isValidEmail = false
    @State var showEmailError = false
    @State var showPasswordError = false
    
    var isValidPassword: Bool {
        !password.isEmpty
    }
    
    @MainActor
    private func loginUser() async {
        do {
            error = ""
            isLoading = true
            
            let result = try await apiService.login(payload: LoginPayload(email: email.lowercased().trimmingCharacters(in: .whitespaces), password: password))
            await userState.updateUserAndJwt(jwt: result.token, user: result.user)
        } catch let error as APIError {
            self.error = error.errorMessage
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    var body: some View {
        ScrollVStack(spacing: 30) {
            Banner(image: Image(.plane), text: "Flight Radar.", textAlignment: .leading)
                .cornerRadius()
            
            Text("Login")
                .textStyle(.textSecondary, size: 40, weight: .semibold)
            
            VStack(spacing: 20) {
                InputWrapper(label: "Email", errorMessage: showEmailError ? "Please provide a properly formatted email" : nil) {
                    EmailTextField(email: $email, isValid: $isValidEmail)
                }
                
                InputWrapper(label: "Password", errorMessage: showPasswordError ? "Password cannot be empty" : nil) {
                    PasswordField(password: $password)
                }
                
                NavigationLink(destination: RegistrationView()) {
                    Text("Forgot Password?")
                        .textStyle(.textSecondary, size: 14, weight: .semibold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                FRButton(
                    "Login",
                    width: .fill,
                    padding: 16,
                    isLoading: isLoading
                ) {
                    showEmailError = !isValidEmail
                    showPasswordError = !isValidPassword
                    if (isValidEmail && isValidPassword) {
                        Task {
                            await loginUser()
                        }
                    }
                }
                .cornerRadius()
                
                if !error.isEmpty {
                    ErrorView(error: error, width: .fill)
                }
            }
                        
            HStack(alignment: .center) {
                Text("Don't have an account?")
                    .textStyle(.textSecondary, size: 15, weight: .bold)
                
                NavigationLink(destination: RegistrationView()) {
                    Text("Register Now")
                        .textStyle(.gold, size: 15, weight: .bold)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
                .environmentObject(ApiService(nil))
                .environmentObject(UserState())
        }
    }
}
