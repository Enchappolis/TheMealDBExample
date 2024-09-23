//
//  APIClientTests.swift
//  TheMealDBExampleTests
//
//  Created by Enchappolis on 8/21/24.
//

import XCTest
@testable import TheMealDBExample

final class APIClientTests: NetworkManagerTesting {

    func test_fetch_dessert_is_valid() async throws {

        let networkManager = try await getMockNetworkManagerUsingDataFrom(file: "MockMealResponse")
        
        XCTAssertNotNil(networkManager, "NetworkManager is nil")
        
        let apiClient = APIClient(networkManager: networkManager!)
        
        let mealResponse = try await apiClient.fetchDesserts()
        
        let mockMealResponse = try MockData.getMockMealResponse()
        
        XCTAssertEqual(mealResponse, mockMealResponse, "MealResponse does not match")
        
        XCTAssertEqual(mealResponse.meals[0].id, "53049", "Wrong meal id")
        
        XCTAssertEqual(mealResponse.meals[0].name, "Apam balik", "Wrong meal name")
    }
}
