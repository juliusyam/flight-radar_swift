//
//  Models.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import Foundation

struct AuthResponse: Codable, Equatable {
    let user: UserResponse
    let token: String
}

struct UserResponse: Codable, Equatable {
    let name: String
    let email: String
    let updatedAt: String
    let createdAt: String
    let emailVerifiedAt: String?
    let id: Int
}

struct ErrorResponse: Codable {
    let message: String?
    let errors: [String: [String]]?
    let status: Bool?
}
