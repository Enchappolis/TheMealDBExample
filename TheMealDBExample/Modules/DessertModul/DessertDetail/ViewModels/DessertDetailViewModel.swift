//
//  DessertDetailViewModel.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/17/24.
//

import Foundation

@MainActor
class DessertDetailViewModel: ObservableObject {
    
    @Published private(set) var state: MealDetailViewState = .idle
    
    private let apiClient: APIClient

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchMealDetail(id: String) async {
        
        guard state != .loading else { return }

        state = .loading

        do {

            let mealDetail = try await apiClient.fetchMealDetail(id: id)

            state = .loaded(mealDetail: mealDetail)
            
        } catch {
          
            state = .error(error.localizedDescription)
        }
    }
}
