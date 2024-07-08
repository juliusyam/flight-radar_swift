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
