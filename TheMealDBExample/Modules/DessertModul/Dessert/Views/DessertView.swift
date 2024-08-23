//
//  DessertView.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/17/24.
//

import SwiftUI

struct DessertView: View {
    
    @StateObject private var viewModel = DessertViewModel()

    @State private var searchText = ""
    
    var body: some View {
        
    #if DEBUG
        let _ = Self._printChanges()
    #endif
        
        NavigationView {
            
            ZStack {
                background
                showGridView
            }
            .navigationTitle("Desserts")
        }
        .task {
            await viewModel.fetchDesserts()
        }
        .refreshable {
            refreshDeserts()
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText) { value in
            viewModel.searchMeals(query: value)
        }
    }
    
    @ViewBuilder
    var showGridView: some View {
        
        switch viewModel.state {
        case .idle:
            idleView
        case .loading:
            ProgressView("Loading...")
                .padding()
        case .error(let title, let message):
            ErrorView(title: title, message: message, buttonText: "Reload") {
                fetchDeserts()
            }
        case .loaded(let meals):
            DessertGridView(meals: meals)
        }
    }
    
    private func fetchDeserts() {
        Task {
            await viewModel.fetchDesserts()
        }
    }
    
    private func refreshDeserts() {
        Task {
            await viewModel.refreshDesserts(category: .dessert)
        }
    }
    
    private var idleView: some View {
        
        VStack {
            Text("No meals loaded.")
                .padding()
            Button(action: {
                fetchDeserts()
            }, label: {
                Text("Reload Desserts")
            })
            .buttonStyle(.custom)
        }
    }
    
    var background: some View {
        ColorTheme.background
            .ignoresSafeArea()
    }
}

struct DessertView_Preview: View {
    
    @StateObject private var viewModel = DessertViewModel()
    
    var body: some View {
        DessertView()
    }
}

#Preview {
    DessertView_Preview()
}
