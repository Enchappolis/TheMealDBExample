//
//  MealDetailViewState.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/17/24.
//

import Foundation

enum MealDetailViewState: Equatable {
    case idle
    case loading
    case loaded(mealDetail: MealDetail)
    case error(String)
    
    static func == (lhs: MealDetailViewState, rhs: MealDetailViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
}
