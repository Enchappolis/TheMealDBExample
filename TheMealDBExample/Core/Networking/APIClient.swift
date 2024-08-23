//
//  APIClient.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/16/24.
//

import Foundation

final class APIClient {

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchDesserts() async throws -> MealResponse {
        let endpoint = APIEndpoint.filterByCategory(category: MealCategory.dessert.value)
        return try await networkManager.request(endpoint: endpoint, responseType: MealResponse.self)
    }

    func fetchMealDetail(id: String) async throws -> MealDetail {
        
        let endpoint = APIEndpoint.lookupMeal(id: id)
        let response = try await networkManager.request(endpoint: endpoint, responseType: MealDetailResponse.self)
        
        guard let mealDetail = response.meals.first else {
            throw URLError(.resourceUnavailable) // Handle the case where no meal details are found
        }
        return mealDetail
    }
}
