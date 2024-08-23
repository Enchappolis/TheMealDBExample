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

import Foundation

enum APIEndpoint {
    case filterByCategory(category: String)
    case lookupMeal(id: String)

    private func urlComponents(for endpoint: APIEndpoint) -> URLComponents {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "themealdb.com"
        components.path = "/api/json/v1/1"
        
        switch endpoint {
        case .filterByCategory(let category):
            components.path += "/filter.php"
            components.queryItems = [
                URLQueryItem(name: "c", value: category)
            ]

        case .lookupMeal(let id):
            components.path += "/lookup.php"
            components.queryItems = [
                URLQueryItem(name: "i", value: id)
            ]
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
        case .filterByCategory(_), .lookupMeal(_):
            return .GET
        }
    }
}
