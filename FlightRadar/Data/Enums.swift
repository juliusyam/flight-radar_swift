//
//  Enums.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import Foundation

enum ApiMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidUrl(message: String? = nil)
    case failedResponse(statusCode: Int, message: String? = nil)
    case validationErrors(errors: [String: [String]], message: String? = nil)
    case unAuthorised(message: String? = nil)
    case invalidResponse(message: String? = nil)
    case unknown(Error, message: String? = nil)
    
    var errorMessage: String {
        switch self {
        case .invalidUrl(let message):
            return message ?? localizedDescription
        case .failedResponse(let statusCode, let message):
            return "\(message ?? "Request failed")\nStatus code: \(statusCode)"
        case .validationErrors(let errors, let message):
            let errorString = errors.map { "\($0.key): \($0.value.joined(separator: ", "))" }.joined(separator: "\n")
            return "\(message ?? "Validation errors occurred:")\n\(errorString)"
        case .unAuthorised(let message):
            return message ?? localizedDescription
        case .invalidResponse(let message):
            return message ?? localizedDescription
        case .unknown(let underlyingError, let message):
            return message ?? underlyingError.localizedDescription
        }
    }
}
