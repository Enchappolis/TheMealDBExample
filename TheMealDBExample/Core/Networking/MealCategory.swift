//
//  MealCategory.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/16/24.
//

import Foundation

enum MealCategory {
    case dessert
    
    var value: String {
        switch self {
        case .dessert:
            return "Dessert"
        }
    }
}
