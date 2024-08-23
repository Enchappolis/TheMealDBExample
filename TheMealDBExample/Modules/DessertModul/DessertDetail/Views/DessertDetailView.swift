//
//  DessertDetailView.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/17/24.
//

import SwiftUI

struct DessertDetailView: View {
    
    @StateObject private var viewModel = DessertDetailViewModel()
    
    private let mealId: String
    
    init(mealId: String) {
        self.mealId = mealId
    }
    
    var body: some View {
        
        ZStack {
            background
            showDetailView
        }
        // Fix for iOS bug: Disable pull to refresh.
        // https://stackoverflow.com/questions/72160368/how-to-disable-refreshable-in-nested-view-which-is-presented-as-sheet-fullscreen
        .environment(\EnvironmentValues.refresh as! WritableKeyPath<EnvironmentValues, RefreshAction?>, nil)
        
        .padding(.horizontal)
        .task {
            await viewModel.fetchMealDetail(id: mealId)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ReusableToolbarContent(imageSymbol: .chevronBack)
        }
    }
    
    @ViewBuilder
    var showDetailView: some View {
       
        switch viewModel.state {
        case .idle:
            Text("No details available.")
                .padding()
            
        case .loading:
            ProgressView("Loading...")
                .padding()
            
        case .loaded(let mealDetail):
            
            DessertDetailContentView(mealDetail: mealDetail)
//                .background(ColorTheme.background)
                .navigationTitle(mealDetail.name)
            
        case .error(let errorMessage):
            Text("Error: \(errorMessage)")
                .foregroundColor(.red)
                .padding()
        }
    }
    
    var background: some View {
        ColorTheme.background
            .ignoresSafeArea()
    }
}

struct DessertDetailView_Preview: View {
    
    @State private var meals: [Meal] = []
    
    var body: some View {
        
        DessertDetailView(mealId: try! MockData.getMealId())
    }
}

#Preview {
    NavigationView {
        DessertDetailView_Preview()
    }
}
