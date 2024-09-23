//
//  NetworkManager.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/16/24.
//

import Foundation

protocol NetworkManagerProtocol: Sendable {
    func request<T: Decodable>(endpoint: APIEndpoint,
                               responseType: T.Type) async throws -> T
}

actor NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager(urlSession: URLSession.shared)
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request<T: Decodable & Sendable>(endpoint: APIEndpoint,
                               responseType: T.Type) async throws -> T {
       
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        do {
            
            let request = buildRequest(from: url, methodType: endpoint.methodType)
            
            let (data, response) = try await fetchData(with: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            // Success
            case 200...299:
                return try decodeObject(object: responseType, data: data)
                
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 500:
                throw NetworkError.internalServerError
            case 503:
                throw NetworkError.serviceUnavailable
            default:
                throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
            }
            
        } catch {
            
            guard let networkError = error as? NetworkError else {
                let errorMessage = (error as NSError).localizedDescription
                throw NetworkError.networkError(reason: errorMessage)
            }
            
            throw networkError
        }
    }
    
    private func decodeObject<T: Decodable>(object: T.Type, data: Data) throws -> T {
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            let errorMessage = (error as NSError).localizedDescription
            throw NetworkError.decodingError(reason: errorMessage)
        }
    }
    
    private func buildRequest(from url: URL,
                              methodType: APIEndpoint.MethodType) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        }
        return request
    }
    
    // Fetch data using a continuation to avoid warnings about non-Sendable types.
    private func fetchData(with urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = urlSession.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
            task.resume()
        }
    }
}
