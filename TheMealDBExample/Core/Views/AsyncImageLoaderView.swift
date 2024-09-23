//
//  AsyncImageLoaderView.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/17/24.
//

import SwiftUI

struct AsyncImageLoaderView: View {
    
    @State private var image: UIImage?
    @State private var isLoading: Bool = false
    
    private let imageURL: URL?
    private let cache = ImageCacheManager()
    private let cornerRadius: CGFloat
    
    init(imageURL: URL?, cornerRadius: CGFloat = 0) {
        self.imageURL = imageURL
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo.fill")
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .task {
            await loadImage()
        }
    }
    
    @MainActor
    private func loadImage() async {
        isLoading = true
        self.image = await cache.fetchImage(from: imageURL)
        isLoading = false
    }
}

struct AsyncImageLoaderView_Preview: View {
    
    @State private var url: URL?
    
    init(url: URL? = nil) {
        self.url = try? MockData.getOneMeal()?.thumbnailURL
    }
    
    var body: some View {
        AsyncImageLoaderView(imageURL: url)
    }
}

#Preview {
    
    AsyncImageLoaderView_Preview()
        .padding()
}

#Preview("wrong url") {
    AsyncImageLoaderView(imageURL: URL(string: "https://example.com/icon.png")!)
}


