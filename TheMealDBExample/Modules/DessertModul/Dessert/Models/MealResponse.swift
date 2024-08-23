//
//  MealResponse.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/16/24.
//

import Foundation

struct MealResponse: Codable, Equatable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let thumbnailURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }  
}
