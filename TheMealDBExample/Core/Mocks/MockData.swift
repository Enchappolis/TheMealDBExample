//
//  MockData.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/17/24.
//

import Foundation

struct MockData {
    
    static func getMockMealResponse() throws -> MealResponse? {
        
        return try decode(fileName: "MockMealResponse", type: MealResponse.self)
    }
    
    static func getMockMealDetailResponse() throws -> MealDetailResponse? {
        
        return try decode(fileName: "MockMealDetailResponse", type: MealDetailResponse.self)
    }
    
    static func getDataFrom(fileName: String) throws -> Data {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw MockDataError.JSONFileNotFound
        }
        
        let data = try Data(contentsOf: url)
        
        return data
    }
    
    static func decode<T: Decodable>(fileName: String, type: T.Type) throws -> T {
        
        let data = try getDataFrom(fileName: fileName)
        
        do {
            
            let response = try JSONDecoder().decode(T.self, from: data)
            
            return response
            
        } catch {
            
            throw MockDataError.decodingError
        }
    }
    
    static func getOneMeal() throws -> MealDetail? {
        
        let mealDetailResponse = try getMockMealDetailResponse()
        
        guard let mealDetailResponse = mealDetailResponse else {
            return nil
        }
        
        return mealDetailResponse.meals.first
    }
    
    static func getMeals() throws -> [Meal] {
        
        let mealResponse = try getMockMealResponse()
        
        guard let mealResponse = mealResponse else {
            return []
        }
        
        return mealResponse.meals
    }
    
    static func getMealId() throws -> String {
        
        let mealDetail = try getOneMeal()
        
        return mealDetail?.id ?? ""
    }
}

extension MockData {
    
    enum MockDataError: Error {
        case JSONFileNotFound
        case decodingError
        case getMealResponseError
    }
}
