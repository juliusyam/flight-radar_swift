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
    @State var isLoading: Bool = false
    @State var error: String = ""
    @State var disableButton = false
    
    var isButtonDisabled: Bool {
        return name.isEmpty || email.isEmpty || password.isEmpty || disableButton
    }
    
    @MainActor
    private func registerUser() async {
        do {
            error = ""
            isLoading = true
            
            let result = try await apiService.register(payload: RegisterPayload(name: name.lowercased().trimmingCharacters(in: .whitespaces), email: email.lowercased().trimmingCharacters(in: .whitespaces), password: password))
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
            Text("Registration")
                .titleStyle()
                .padding(.bottom, 50)
            
            VStack(spacing: 20) {
                TextField("Name", text: $name)
                    .padding()
                    .textFieldBackground()
                
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
                        await registerUser()
                    }
                }) {
                    Text("Register")
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
            }
            .padding(.horizontal, 30)
        }
        .linearGradientBackground()
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
