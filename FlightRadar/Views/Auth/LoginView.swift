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
    @State var disableButton = false
    
    var isButtonDisabled: Bool {
        return email.isEmpty || password.isEmpty || disableButton
    }
    
    @MainActor
    private func loginUser() async {
        do {
            error = ""
            isLoading = true
            
            let result = try await apiService.login(payload: LoginPayload(email: email.lowercased().trimmingCharacters(in: .whitespaces), password: password))
            await userState.updateUser(jwt: result.token, user: result.user)
        } catch let error as APIError {
            self.error = error.errorMessage
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    var body: some View {
        
        VStack {
            Text("Login")
                .titleStyle()
                .padding(.bottom, 50)
            
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .padding()
                    .textFieldBackground()
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onChange(of: email) { _ in
                        disableButton = !email.emailIsValid()
                    }
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldBackground()
                
                Button(action: {
                    Task {
                        await loginUser()
                    }
                }) {
                    Text("Login")
                        .padding()
                        .buttonStyle()
                }
                .disabled(isButtonDisabled)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
                
                if !error.isEmpty {
                    ErrorView(error: error)
                }
                
                NavigationLink(destination: RegistrationView()) {
                    Text("Don't have an account? Register")
                        .foregroundColor(.white)
                        .padding(.top)
                }
            }
            .padding(.horizontal, 30)
        }
        .linearGradientBackground()
        .navigationBarBackButtonHidden(true)
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
