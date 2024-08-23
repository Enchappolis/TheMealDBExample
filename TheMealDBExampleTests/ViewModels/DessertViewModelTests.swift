//
//  DessertViewModelTests.swift
//  TheMealDBExampleTests
//
//  Created by Enchappolis on 8/21/24.
//

import XCTest
import Combine
@testable import TheMealDBExample

final class DessertViewModelTests: NetworkManagerTesting {
    
    var networkManager: (any NetworkManagerProtocol)!
    var dessertViewModel: DessertViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {

        try super.setUpWithError()
       
        networkManager = try getMockNetworkManagerUsingDataFrom(file: "MockMealResponse")
        
        XCTAssertNotNil(networkManager, "NetworkManager is nil")
        
        let apiClient = APIClient(networkManager: networkManager!)
        
        dessertViewModel = DessertViewModel(apiClient: apiClient)
    }
    
    override func tearDownWithError() throws {
 
        try super.tearDownWithError()

        networkManager = nil
        dessertViewModel = nil
        cancellables.removeAll()
    }
    
    func test_fetch_dessert_is_valid() async throws {
        
        // Expectation for the data change.
        let expectation = XCTestExpectation(description: "Dessert should be loaded")
        
        // Observe the state property.
        dessertViewModel.$state
            .dropFirst() // Drop the initial value (idle)
            .sink { state in
                switch state {
                case .loading:
                    XCTAssertEqual(state, .loading, "state expected to be of type .loading")
                case .loaded(let meals):
                    
                    XCTAssertNotNil(meals[0], "Meal should not be nil")
                    XCTAssertEqual(meals[0].id, "53049", "Meal has wrong id.")
                    XCTAssertEqual(meals[0].name, "Apam balik", "Meal has wrong name")
                    
                default:
                    XCTFail("fetching desserts did not return values")
                    break
                }
            }
            .store(in: &cancellables)
        
        await dessertViewModel.fetchDesserts()
        
        // Wait for the expectation.
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func test_search_is_valid() async throws {
        
        var testForSearch = false
        
        let expectation = XCTestExpectation(description: "Dessert should be loaded")
        
        // Observe the state property.
        dessertViewModel.$state
            .dropFirst() // Drop the initial value (idle)
            .sink { state in
                switch state {
                case .loading:
                    XCTAssertEqual(state, .loading, "state expected to be of type .loading")
                case .loaded(let meals):
                    
                    if testForSearch {
                        
                        XCTAssertEqual(meals.count, 3, "Wrong number of meals returned")
                        
                        XCTAssertNotNil(meals[0], "Meal should not be nil")
                        XCTAssertEqual(meals[0].id, "53049", "Meal has wrong id.")
                        XCTAssertEqual(meals[0].name, "Apam balik", "Meal has wrong name")
                        
                        XCTAssertNotNil(meals[1], "Meal should not be nil")
                        XCTAssertEqual(meals[1].id, "52893", "Meal has wrong id.")
                        XCTAssertEqual(meals[1].name, "Apple & Blackberry Crumble", "Meal has wrong name")
                    }
                    
                default:
                    XCTFail("fetching desserts did not return values")
                    break
                }
            }
            .store(in: &cancellables)
        
        await dessertViewModel.fetchDesserts()
        
        testForSearch = true
        await dessertViewModel.searchMeals(query: "a")
        
        // Wait for the expectation.
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    // Helper function to await XCTestExpectation.
    private func fulfillment(of expectations: [XCTestExpectation], timeout: TimeInterval) async {
        await withCheckedContinuation { continuation in
            XCTWaiter().wait(for: expectations, timeout: timeout)
            continuation.resume()
        }
    }
}
