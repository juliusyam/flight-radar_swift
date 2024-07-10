//
//  Models.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import Foundation

struct AuthResponse: Codable, Equatable {
    let user: User
    let token: String
}

struct User: Codable, Equatable {
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

struct Flight: Codable {
    let id: Int
    let userId: Int
    let departureDate: String
    let flightNumber: String
    let departureAirport: String
    let arrivalAirport: String
    let distance: Int
    let airline: String
    let createdAt: String
    let updatedAt: String
}
