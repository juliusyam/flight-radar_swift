//
//  Payloads.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import Foundation

struct RegisterPayload: Codable {
    let name: String
    let email: String
    let password: String
}

struct LoginPayload: Codable {
    let email: String
    let password: String
}

struct FlightPayload: Codable {
    let departureDate: String
    let flightNumber: String
    let departureAirport: String
    let arrivalAirport: String
    let distance: Int
    let airline: String
}

struct EmptyPayload: Codable {}

struct FlightQueryParams {
    let airline: String?
    let airport: String?
}
