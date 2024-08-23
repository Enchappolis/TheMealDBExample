//
//  MealsViewState.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/17/24.
//

import Foundation

enum MealsViewState: Equatable {
    case idle
    case loading
    case loaded(meals: [Meal])
    case error(title: String, message: String)
    
    static func == (lhs: MealsViewState, rhs: MealsViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
}
