//
//  MealDetailResponse.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/16/24.
//

import Foundation

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

struct IngredientMeasure: Identifiable {
    let id = UUID()
    let ingredient: String
    let measure: String
}

struct MealDetail: Codable {
    let id: String
    let name: String
    let drinkAlternate: String?
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnailURL: URL?
    let tags: String?
    let youtubeURL: URL?
    let source: String?
    let ingredientMeasures: [IngredientMeasure]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnailURL = "strMealThumb"
        case tags = "strTags"
        case youtubeURL = "strYoutube"
        case source = "strSource"
    }
    
    // Custom initializer to handle dynamic number of ingredients and measures.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        drinkAlternate = try container.decodeIfPresent(String.self, forKey: .drinkAlternate)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        thumbnailURL = try container.decodeIfPresent(URL.self, forKey: .thumbnailURL)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        youtubeURL = try container.decodeIfPresent(URL.self, forKey: .youtubeURL)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        
        // Decode the raw data into a dictionary of strings.
        let rawContainer = try decoder.singleValueContainer()
        let allFields = try rawContainer.decode([String: String?].self)
        
        var ingredientMeasures: [IngredientMeasure] = []
        
        // Extract all keys that match the pattern for ingredients and measures.
        let ingredientsKeys = allFields.keys.filter { $0.starts(with: "strIngredient") }
        let measureKeys = allFields.keys.filter { $0.starts(with: "strMeasure") }
        
        // Find the maximum index by checking the available keys.
        let maxIndex = max(ingredientsKeys.count, measureKeys.count)
        
        // Iterate over the range 1...maxIndex and decode corresponding ingredient-measure pairs.
        for index in 1...maxIndex {
           
            let ingredientsKey = "strIngredient\(index)"
            let measureKey = "strMeasure\(index)"
            
            // Retrieve the ingredient and measure, allowing for nil or empty strings.
            let rawIngredient = allFields[ingredientsKey] ?? nil
            let ingredient = rawIngredient?.isEmpty == false ? rawIngredient : nil
            
            // Check if we should add this pair.
            if ingredient == nil {
                continue
            }
            
            let rawMeasure = allFields[measureKey] ?? nil
            let measure = rawMeasure?.isEmpty == false ? rawMeasure : nil
            
            // Append the ingredient-measure pair to the array.
            ingredientMeasures.append(IngredientMeasure(ingredient: ingredient ?? "", measure: measure ?? ""))
        }
        
        self.ingredientMeasures = ingredientMeasures
    }
}
