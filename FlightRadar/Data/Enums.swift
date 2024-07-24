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

enum FRTab: Equatable {
  case dashboard, flights, settings
}

enum APIError: Error {
    case invalidUrl(message: String? = nil)
    case failedResponse(statusCode: Int, message: String? = nil)
    case validationErrors(errors: [String: [String]], message: String? = nil)
    case expiredToken(message: String? = nil)
    case forbidden(message: String? = nil)
    case unauthorized(message: String? = nil)
    case invalidResponse(message: String? = nil)
    case unknown(Error, message: String? = nil)
    case loginRequired(message: String? = nil)
    
    var errorMessage: String {
        switch self {
        case .invalidUrl(let message):
            return message ?? localizedDescription
        case .failedResponse(let statusCode, let message):
            return "\(message ?? "Request failed")\nStatus code: \(statusCode)"
        case .validationErrors(let errors, let message):
            let errorString = errors.map { "\($0.key): \($0.value.joined(separator: ", "))" }.joined(separator: "\n")
            return "\(message ?? "Validation errors occurred:")\n\(errorString)"
        case .expiredToken(let message):
            return message ?? "Token has expired. Please refresh your session."
        case .forbidden(let message):
            return message ?? "Access forbidden. You don't have permission to access this resource."
        case .unauthorized(let message):
            return message ?? "Unauthorized access. Please check your credentials."
        case .invalidResponse(let message):
            return message ?? localizedDescription
        case .unknown(let underlyingError, let message):
            return message ?? underlyingError.localizedDescription
        case .loginRequired(let message):
            return message ?? "Login required. Please log in to continue."
        }
    }
}

enum FlightOption: String, CaseIterable {
    case all = "all"
    case airplane = "airplane"
    case airport = "airport"
}

enum ButtonWidth {
    case fit
    case fill
    case fixed(CGFloat)
}

enum ErrorViewWidth {
    case fit
    case fill
}

enum IconPosition {
    case left, right
}
