//
//  UserState.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import Foundation
import KeychainSwift

class UserState: ObservableObject {
    @Published var jwt: String?
    @Published var user: User?
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let keychain = KeychainSwift()
    
    private let jwtKey = "jwt"
    private let userKey = "user"
    
    init() {
        if let jwt = keychain.get(jwtKey) {
            self.jwt = jwt
        }
        
        if let userData = keychain.getData(userKey),
           let user = try? decoder.decode(User.self, from: userData) {
            self.user = user
        }
    }
    
    func updateUser(user: User) async {
        await MainActor.run {
            self.user = user
            
            if let userData = try? encoder.encode(user) {
                keychain.set(userData, forKey: userKey)
            }
        }
    }
    
    func updateUserAndJwt(jwt: String, user: User) async {
        await MainActor.run {
            self.jwt = jwt
            self.user = user
            
            keychain.set(jwt, forKey: jwtKey)
            if let userData = try? encoder.encode(user) {
                keychain.set(userData, forKey: userKey)
            }
        }
    }
    
    func updateJWT(jwt: String) async {
        await MainActor.run {
            self.jwt = jwt
            keychain.set(jwt, forKey: jwtKey)
        }
    }
    
    func removeUserAndJWT() async {
        await MainActor.run {
            jwt = nil
            user = nil
            
            keychain.delete(jwtKey)
            keychain.delete(userKey)
        }
    }
}
