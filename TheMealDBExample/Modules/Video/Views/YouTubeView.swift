//
//  YouTubeView.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/21/24.
//

import SwiftUI
import WebKit

struct YouTubeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let title: String
    private let youTubeURL: URL?
    
    init(title: String, youTubeURL: URL?) {
        self.title = title
        self.youTubeURL = youTubeURL
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                YouTubePlayerView(videoId: getVideoId(from: youTubeURL))
                    .frame(height: 300)
                
                Text("You can watch the instruction video.")
                    .font(.callout)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxHeight: .infinity, alignment: .top)
            .toolbar {
                ReusableToolbarContent(imageSymbol: .close) {
                    dismiss()
                }
            }
        }
    }
    
    private func getVideoId(from url: URL?) -> String {
    
        var videoID = ""
        
        guard let url = url else { return "" }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let queryItems = urlComponents?.queryItems {
            videoID = queryItems.filter {$0.name == "v"}.first?.value ?? ""
        }
        
        return videoID
    }
}

struct YouTubePlayerView: UIViewRepresentable {
    
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ wkWebView: WKWebView, context: Context) {
       
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
        
        wkWebView.scrollView.isScrollEnabled = false
        wkWebView.load(URLRequest(url: url))
    }
}

struct YouTubeView_Preview: View {
    
    let youTubeURL = try? MockData.getOneMeal()?.youtubeURL
    
    var body: some View {
        YouTubeView(title: "Title", youTubeURL: youTubeURL)
    }
}

#Preview {
    
    YouTubeView_Preview()
}
