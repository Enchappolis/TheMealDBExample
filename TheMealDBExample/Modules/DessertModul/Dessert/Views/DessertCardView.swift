//
//  DessertCardView.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/19/24.
//

import SwiftUI

struct DessertCardView: View {
    
    private let url: URL?
    private let name: String
    
    init(url: URL?, name: String) {
        self.url = url
        self.name = name
    }
    
    var body: some View {
    
        VStack(spacing: .zero) {
            
            AsyncImageLoaderView(imageURL: url, cornerRadius: 10)
                .frame(width: 100, height: 100)
                .padding(.vertical, 6)
            
            Text(name)
                .frame(minHeight: 50, maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .lineLimit(2)
                .foregroundColor(ColorTheme.text)
                .font(.system(.body, design: .rounded))
                .minimumScaleFactor(0.8)
                .padding(.horizontal)
        }
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: ColorTheme.shadow,
                radius: 2, x: 0, y: 2)
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}

struct DessertCardView_Preview: View {
    
    @State private var url: URL?
    
    init(url: URL? = nil) {
        self.url = try? MockData.getOneMeal()?.thumbnailURL
    }
    
    var body: some View {
        DessertCardView(url: url, name: "Meal name")
    }
}

#Preview {
    DessertCardView_Preview()
        .frame(width: 200, height: 200)
}
