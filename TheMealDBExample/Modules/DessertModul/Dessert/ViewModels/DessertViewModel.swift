//
//  DessertViewModel.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/17/24.
//

import SwiftUI

class DessertViewModel: ObservableObject {
    
    @Published var state: MealsViewState = .idle
    @Published var showAlert: Bool = false
    
    // Store all meals for local filtering.
    private var allMeals: [Meal] = []
    private var searchTask: Task<Void, Never>?
    
    private let apiClient: APIClient
    private let cache = ImageCacheManager()
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func fetchDesserts() async {
        
        guard state != .loading else { return }
        
        state = .loading
        
        do {
            
            let mealResponse = try await apiClient.fetchDesserts()
            allMeals = mealResponse.meals.sorted{ $0.name.lowercased() < $1.name.lowercased() }
            state = .loaded(meals: allMeals)
            
        } catch {
            
            state = .error(title: "Error Fetching Desserts", message: error.localizedDescription)
            showAlert = true
        }
    }
    
    @MainActor
    func searchMeals(query: String) {
        searchTask?.cancel()
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
            if !Task.isCancelled {
                await performSearch(query: query)
            }
        }
    }
    
    @MainActor
    private func performSearch(query: String) async {
        
        if query.isEmpty {
            // If the search query is empty, show all users.
            state = .loaded(meals: allMeals)
        } else {
            // Filter meals by name based on the query.
            let filteredMeals = allMeals.filter { $0.name.lowercased().hasPrefix(query.lowercased())}
            // Update the state with the filtered meals.
            state = .loaded(meals: filteredMeals)
        }
    }
    
    @MainActor
    func refreshDesserts(category: MealCategory) async {
        
        // Clear all caches when pulled to refresh.
        cache.clearAllCaches()
        
        await fetchDesserts()
    }
}
