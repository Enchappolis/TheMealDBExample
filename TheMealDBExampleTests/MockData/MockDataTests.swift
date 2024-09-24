//
//  MockDataTests.swift
//  TheMealDBExampleTests
//
//  Created by Enchappolis on 8/20/24.
//

import XCTest
@testable import TheMealDBExample

final class MockDataTests: XCTestCase {

    func test_decode_into_MealResponse_successful() {
        
        XCTAssertNoThrow(try MockData.getMockMealResponse(), "Get MealResponse using MockData did throw error.")
    }

    func test_decode_results_into_MealResponse_successful() {
        
        let mealResponse = try? MockData.getMockMealResponse()
        
        XCTAssertNotNil(mealResponse, "MealResponse should not be nil")
        
        let meal = mealResponse?.meals[0]
        
        XCTAssertNotNil(meal, "Meal should not be nil")
        
        XCTAssertEqual(meal?.id, "53049", "Meal has wrong id.")
        
        XCTAssertEqual(meal?.name, "Apam balik", "Meal has wrong name")

        XCTAssertEqual(meal?.thumbnailURL, URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"), "Meal has wrong url.")
    }
    
    func test_decode_into_MealDetailResponse_successful() {
        
        XCTAssertNoThrow(try MockData.getMockMealDetailResponse(), "Get MealDetailResponse using MockData did throw error.")
    }
    
    func test_decode_results_into_MealDetailResponse_successful() {
        
        let mealDetailResponse = try? MockData.getMockMealDetailResponse()
        
        XCTAssertNotNil(mealDetailResponse, "MealDetailResponse should not be nil")
        
        let meal = mealDetailResponse?.meals[0]
        
        XCTAssertNotNil(meal, "Meal should not be nil")
        
        XCTAssertEqual(meal?.id, "52787", "Meal has wrong id.")
        
        XCTAssertEqual(meal?.name, "Hot Chocolate Fudge", "Meal has wrong name")

        XCTAssertEqual(meal?.thumbnailURL, URL(string: "https://www.themealdb.com/images/media/meals/xrysxr1483568462.jpg"), "Meal has wrong url.")
        
        XCTAssertNotNil(meal?.ingredientMeasures[0].ingredient, "ingredient1 is nil")
        
        XCTAssertEqual(meal?.ingredientMeasures[0].ingredient, "Chocolate Chips", "ingredient1 has wrong ingredient.")
        
        XCTAssertNotNil(meal?.ingredientMeasures[1].ingredient, "ingredient2 is nil")
        
        XCTAssertEqual(meal?.ingredientMeasures[1].ingredient, "Heavy Cream", "ingredient2 has wrong ingredient.")

        XCTAssertNotNil(meal?.ingredientMeasures[2].ingredient, "ingredient3 is nil")
        
        XCTAssertEqual(meal?.ingredientMeasures[2].ingredient, "Condensed Milk", "ingredient3 has wrong ingredient.")
    }
    
    func test_wrong_file_throws_error() {
        
        XCTAssertThrowsError(try MockData.decode(fileName: "wrong file name", type: MealResponse.self))
        
        do {
            _ = try MockData.decode(fileName: "wrong file name", type: MealResponse.self)
            
        } catch {
            
            guard let decodeError = error as? MockData.MockDataError else {
                XCTFail("decodeError is not MockDataError")
                return
            }
            
            XCTAssertEqual(decodeError, MockData.MockDataError.JSONFileNotFound, "decodeError is not JSONFileNotFound")
        }
    }
}
