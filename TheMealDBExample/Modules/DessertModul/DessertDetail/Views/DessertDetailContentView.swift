//
//  DessertDetailContentView.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/21/24.
//

import SwiftUI

struct DessertDetailContentView: View {
    
    @State private var showYoutubePlayer = false
    @State private var showMore = false
    
    private let mealDetail: MealDetail
    
    init(mealDetail: MealDetail) {
        self.mealDetail = mealDetail
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 20) {
                
                AsyncImageLoaderView(imageURL: mealDetail.thumbnailURL, cornerRadius: 10)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                
                YouTubeButton {
                    showYoutubePlayer.toggle()
                }
                
                showDetails
            }
        }
        .sheet(isPresented: $showYoutubePlayer, content: {
            YouTubeView(title: mealDetail.name, youTubeURL: mealDetail.youtubeURL)
        })
    }
    
    var showDetails: some View {
        
        VStack(alignment: .leading) {
            
            Text(mealDetail.area ?? "")
                .font(.headline)
                .padding(.bottom, 10)
            
            ingredients
                .padding(.bottom, 10)
            
            instructions
            
            Label(showMore ? "Show less" : "Show more", systemImage: showMore ? ImageSymbols.chevronUp.name : ImageSymbols.chevronDown.name)
                .font(.subheadline)
                .imageScale(.medium)
                .foregroundStyle(.blue, .white)
                .padding(.top, 6)
                .onTapGesture {
                    showMore.toggle()
                }
        }
        .padding()
        .background(ColorTheme.background)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        )
    }
    
    var ingredients: some View {
        
        VStack(alignment: .leading) {
            
            Text("Ingredients:")
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.bottom, 2)

            HorizontalLine()
                .offset(y: -6)
            
            ForEach(mealDetail.allIngredientsWithMeasures.sorted(by: >), id: \.key) { ingredient, measure in
                
                HStack {
                    
                    ingredientImage(name: ingredient)
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading) {
                        Text(ingredient)
                            .font(.subheadline)
                        
                        Text(measure)
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
            }
        }
    }
    
    @ViewBuilder
    func ingredientImage(name: String) -> some View {
        
        let endpoint = APIEndpoint.ingredientImage(imageName: name)
        
        if let url = endpoint.url {
            AsyncImageLoaderView(imageURL: url, cornerRadius: 10)
        } else {
            Image(systemName: "questionmark.app.fill")
        }
    }
    
    @ViewBuilder
    var instructions: some View {
        
        Text("Instructions:")
            .font(.subheadline)
            .fontWeight(.bold)
            .padding(.bottom, 2)
            
        HorizontalLine()
            .offset(y: -6)
        
        Text(mealDetail.instructions ?? "")
            .font(.subheadline)
            .lineLimit(showMore ? nil : 5)
    }
}

#Preview {
    DessertDetailContentView(mealDetail: try! MockData.getOneMeal()!)
}
