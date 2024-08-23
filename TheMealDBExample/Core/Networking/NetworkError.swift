//
//  NetworkError.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/16/24.
//

import Foundation

enum NetworkError: Error, Equatable, LocalizedError {
    case invalidURL
    case networkError(reason: String)
    case invalidResponse
    case decodingError(reason: String)
    case requestFailed(statusCode: Int)
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case serviceUnavailable
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .networkError(let reason):
            return reason
        case .invalidResponse:
            return "The server responded with an error."
        case .decodingError(let reason):
            return "Failed to decode the response. \(reason)"
        case .requestFailed(statusCode: let statusCode):
            return "The URL request failed with status code: \(statusCode)"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .internalServerError:
            return "Internal Server Error"
        case .serviceUnavailable:
            return "Service Unavailable"
        }
    }
}
