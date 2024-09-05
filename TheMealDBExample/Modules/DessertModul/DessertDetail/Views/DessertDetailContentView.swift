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
            
            Text("Ingredients:")
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.bottom, 2)

            HorizontalLine()
                .offset(y: -6)

            VStack(alignment: .leading) {
                
                ForEach(mealDetail.allIngredientsWithMeasures.sorted(by: >), id: \.key) { ingredient, measure in
                    
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
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
                }
            }
            .padding(.bottom, 10)
            
            Text("Instructions:")
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.bottom, 2)
                
            HorizontalLine()
                .offset(y: -6)
            
            Text(mealDetail.instructions ?? "")
                .font(.subheadline)
                .lineLimit(showMore ? nil : 5)
            
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
}

#Preview {
    DessertDetailContentView(mealDetail: try! MockData.getOneMeal()!)
}
