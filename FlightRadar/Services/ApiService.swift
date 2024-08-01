//
//  ApiService.swift
//  FlightRadar
//
//  Created by KABBA JOSEPH TIMOTHY on 05/07/2024.
//

import CoreLocation
import Foundation

class ApiService: ObservableObject {
    @Published fileprivate(set) var userState: UserState?
    
    private let host: String = "127.0.0.1:8000"
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init(_ userState: UserState?) {
        encoder = JSONEncoder()
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.userState = userState
    }
    
    func login(payload: LoginPayload) async throws -> AuthResponse {
        return try await request(path: "/login", method: .post, payload: payload)
    }
    
    func register(payload: RegisterPayload) async throws -> AuthResponse {
        return try await request(path: "/register", method: .post, payload: payload)
    }
    
    func addFlight(payload: FlightPayload) async throws -> Flight {
        return try await request(path: "/flights", method: .post, payload: payload)
    }
    
    func getFlight(id: Int) async throws -> Flight {
        return try await request(path: "/flights/\(id)", method: .get)
    }
    
    
    func getFlights(params: FlightQueryParams? = nil) async throws -> [Flight] {
        var endpoint = "/flights"
        
        if let params = params {
            var queryItems: [URLQueryItem] = []
            
            if let airline = params.airline {
                queryItems.append(URLQueryItem(name: "airline", value: airline))
            }
            
            if let airport = params.airport {
                queryItems.append(URLQueryItem(name: "airport", value: airport))
            }
            
            if !queryItems.isEmpty {
                endpoint += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
            }
        }
        
        return try await request(path: endpoint, method: .get)
    }
    
    private func createURLRequest<T: Codable>(path: String, method: ApiMethod, payload: T = EmptyPayload()) throws -> URLRequest {
        guard var components = URLComponents(string: "http://\(host)") else {
            throw APIError.invalidUrl()
        }
        components.path = "/api\(path)"
        
        guard let url = components.url else {
            throw APIError.invalidUrl()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let preferredLanguage = NSLocale.current.languageCode ?? "en"
        urlRequest.addValue(preferredLanguage, forHTTPHeaderField: "Accept-Language")
        
        if method != .get {
            let bodyData = try encoder.encode(payload)
            urlRequest.httpBody = bodyData
        }
        
        if let jwt = userState?.jwt {
            urlRequest.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
    
    private func handleResponse<U: Codable>(json: Data, response: URLResponse) async throws -> U {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse(message: "error_incorrect_response_format".localized())
        }
        
        let statusCode = httpResponse.statusCode
        
        switch statusCode {
        case 401:
            await userState?.removeUserAndJWT()
            let errorMessage = try? decoder.decode(ErrorResponse.self, from: json).message
            throw APIError.unauthorized(message: errorMessage)
        case 403:
            let errorMessage = try? decoder.decode(ErrorResponse.self, from: json).message
            throw APIError.forbidden(message: errorMessage ?? "error_access_forbidden".localized())
        case 422:
            let errorResponse = try? decoder.decode(ErrorResponse.self, from: json)
            if let errors = errorResponse?.errors {
                throw APIError.validationErrors(errors: errors, message: errorResponse?.message)
            } else {
                throw APIError.failedResponse(statusCode: statusCode, message: errorResponse?.message)
            }
        case 200..<300:
            return try decoder.decode(U.self, from: json)
        default:
            let errorMessage = try? decoder.decode(ErrorResponse.self, from: json).message
            throw APIError.failedResponse(statusCode: statusCode, message: errorMessage)
        }
    }

    private func refreshToken() async throws -> RefreshToken {
        let urlRequest = try createURLRequest(path: "/refresh", method: .get)
        
        do {
            let (json, response) = try await URLSession.shared.data(for: urlRequest)
            return try await handleResponse(json: json, response: response)
        } catch {
            if let apiError = error as? APIError {
                switch apiError {
                case .unauthorized, .forbidden:
                    await userState?.removeUserAndJWT()
                    throw APIError.loginRequired()
                default:
                    throw apiError
                }
            } else {
                throw APIError.unknown(error)
            }
        }
    }

    private func request<T: Codable, U: Codable>(path: String, method: ApiMethod, payload: T = EmptyPayload()) async throws -> U {
        let urlRequest = try createURLRequest(path: path, method: method, payload: payload)
        
        do {
            let (json, response) = try await URLSession.shared.data(for: urlRequest)
            return try await handleResponse(json: json, response: response)
        } catch {
            if let apiError = error as? APIError {
                switch apiError {
                case .forbidden:
                    do {
                        let newToken: RefreshToken = try await refreshToken()
                        await userState?.updateJWT(jwt: newToken.token)
                        return try await request(path: path, method: method, payload: payload)
                    } catch {
                        throw error
                    }
                default:
                    throw apiError
                }
            } else {
                throw APIError.unknown(error)
            }
        }
    }
}
