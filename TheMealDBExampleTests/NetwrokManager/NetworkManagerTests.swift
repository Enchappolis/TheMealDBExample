//
//  NetworkManagerTests.swift
//  TheMealDBExampleTests
//
//  Created by Enchappolis on 8/20/24.
//

import XCTest
@testable import TheMealDBExample

final class NetworkManagerTests: NetworkManagerTesting {

    func test_response_is_valid() async throws {
        
        let networkManager = try getMockNetworkManagerUsingDataFrom(file: "MockMealResponse")
        
        XCTAssertNotNil(networkManager, "NetworkManager is nil")
        
        let mealResponse = try await networkManager!.request(endpoint: .filterByCategory(category: "Dessert"), responseType: MealResponse.self)
        
        let mockMealResponse = try MockData.getMockMealResponse()
        
        XCTAssertEqual(mealResponse, mockMealResponse, "MealResponse does not match")
        
        XCTAssertEqual(mealResponse.meals[0].id, "53049", "Wrong meal id")
        
        XCTAssertEqual(mealResponse.meals[0].name, "Apam balik", "Wrong meal name")
    }

    func test_unsucessful_response_uses_correct_statuscode_error() async throws {
        
        let statusCodeUnauthorized = 401
        
        let networkManager = try getMockNetworkManagerUsingDataFrom(file: "MockMealResponse",
                                                                    withStatusCode: statusCodeUnauthorized)
        
        XCTAssertNotNil(networkManager, "NetworkManager is nil")
        
        do {
            _ = try await networkManager!.request(endpoint: .filterByCategory(category: "Dessert"), responseType: MealResponse.self)
        } catch {
            
            guard let networkError = error as? NetworkError else {
                XCTFail("Wrong error type. Exprected type NetworkError")
                return
            }
            
            XCTAssertEqual(networkError, .unauthorized, "Expected error of type unauthorized")
        }
    }
}
