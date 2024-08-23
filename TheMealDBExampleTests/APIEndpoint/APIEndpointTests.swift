//
//  APIEndpointTests.swift
//  TheMealDBExampleTests
//
//  Created by Enchappolis on 8/20/24.
//

import XCTest
@testable import TheMealDBExample

final class APIEndpointTests: XCTestCase {

    func test_filter_endpoint_request_is_valid() {
        
        let endpoint = APIEndpoint.filterByCategory(category: "Dessert")
        
        XCTAssertEqual(endpoint.methodType, .GET, "Enpoint should be GET")
        
        XCTAssertEqual(endpoint.url, URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"), "Wrong url")
        
        XCTAssertEqual(endpoint.url?.scheme, "https", "Wrong scheme")
        
        // Test path components.
        // URL: https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
        let pathComponents = endpoint.url?.pathComponents
        
        XCTAssertNotNil(pathComponents, "pathComponents are nil")
        
        XCTAssertEqual(pathComponents?[1], "api", "pathComponents[1] is wrong")
        XCTAssertEqual(pathComponents?[2], "json", "pathComponents[2] is wrong")
        XCTAssertEqual(pathComponents?[3], "v1", "pathComponents[3] is wrong")
        XCTAssertEqual(pathComponents?[4], "1", "pathComponents[4] is wrong")
        XCTAssertEqual(pathComponents?[5], "filter.php", "pathComponents[5] is wrong")
    }
    
    func test_lookup_endpoint_request_is_valid() {
       
        let endpoint = APIEndpoint.lookupMeal(id: "52772")
        
        XCTAssertEqual(endpoint.methodType, .GET, "Enpoint should be GET")
        
        XCTAssertEqual(endpoint.url, URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=52772"), "Wrong url")
        
        XCTAssertEqual(endpoint.url?.scheme, "https", "Wrong scheme")
        
        // Test path components.
        // URL: https://themealdb.com/api/json/v1/1/lookup.php?i=52772
        let pathComponents = endpoint.url?.pathComponents
        
        XCTAssertNotNil(pathComponents, "pathComponents are nil")
        
        XCTAssertEqual(pathComponents?[1], "api", "pathComponents[1] is wrong")
        XCTAssertEqual(pathComponents?[2], "json", "pathComponents[2] is wrong")
        XCTAssertEqual(pathComponents?[3], "v1", "pathComponents[3] is wrong")
        XCTAssertEqual(pathComponents?[4], "1", "pathComponents[4] is wrong")
        XCTAssertEqual(pathComponents?[5], "lookup.php", "pathComponents[5] is wrong")
    }
}
