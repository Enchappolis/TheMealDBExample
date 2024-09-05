//
//  APIEndpoint.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/16/24.
//

// Examples

// For fetching the list of meals in the Dessert category.
// c = category.
// https://themealdb.com/api/json/v1/1/filter.php?c=Dessert

// For fetching the meal details by its ID.
// i = MEADL_ID.
// https://themealdb.com/api/json/v1/1/lookup.php?i=52772

// For fetching ingredient image.
// .../ingredients/<ingredient name>-small.png
// https://themealdb.com/images/ingredients/Lime-Small.png

import Foundation

enum APIEndpoint {
    case filterByCategory(category: String)
    case lookupMeal(id: String)
    case ingredientImage(imageName: String)
    
    private func urlComponents(for endpoint: APIEndpoint) -> URLComponents {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "themealdb.com"
        
        let apiPath = "/api/json/v1/1"
        
        switch endpoint {
        case .filterByCategory(let category):
            components.path += apiPath
            components.path += "/filter.php"
            components.queryItems = [
                URLQueryItem(name: "c", value: category)
            ]

        case .lookupMeal(let id):
            components.path += apiPath
            components.path += "/lookup.php"
            components.queryItems = [
                URLQueryItem(name: "i", value: id)
            ]
        case .ingredientImage(let imageName):
            components.path += "/images/ingredients/\(imageName)-Small.png"
        }

        return components
    }

    var url: URL? {
        return urlComponents(for: self).url
    }
}

extension APIEndpoint {
    enum MethodType: Equatable {
        case GET
    }
    
    var methodType: MethodType {
        switch self {
        case .filterByCategory(_), .lookupMeal(_),.ingredientImage(_) :
            return .GET
        }
    }
}
