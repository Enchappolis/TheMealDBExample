//
//  DessertGridView.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/19/24.
//

import SwiftUI

struct DessertGridView: View {
    
    private let meals: [Meal]
    private let columns = Array(repeating: GridItem(.flexible()),
                                count: 2)
    
//    @State private var searchText = ""
    
    init(meals: [Meal]) {
        self.meals = meals
    }
    
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: columns,
                      spacing: 0) {
                
                ForEach(meals) { meal in
                    
                    NavigationLink {
                        DessertDetailView(mealId: meal.id)
                    } label: {
                        DessertCardView(url: meal.thumbnailURL, name: meal.name)
                    }
                }
            }
                      .padding()
        }
        .background(.gray.opacity(0.1))
        
    }
}

struct DessertGridView_Preview: View {
    
    @State private var meals: [Meal] = []
    
    var body: some View {
        
        DessertGridView(meals: try! MockData.getMeals())
    }
}

#Preview {
    NavigationView {
        DessertGridView_Preview()
            .navigationTitle("Dessert")
    }
}

