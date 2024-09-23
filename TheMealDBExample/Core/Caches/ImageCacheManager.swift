//
//  ImageCacheManager.swift
//  TheMealDBTestApp
//
//  Created by Enchappolis on 8/17/24.
//

import SwiftUI

actor ImageCacheManager {
    
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private var memoryCache = NSCache<NSString, UIImage>()
    
    init() {
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        cacheDirectory = cachesDirectory.appendingPathComponent("ImageCache")
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    private func cacheImage(_ image: UIImage, for url: URL?) {
        
        guard let url else { return }
        
        if memoryCache.object(forKey: url.absoluteString as NSString) != nil {
            return
        }
        
        // Cache the image in memory.
        memoryCache.setObject(image, forKey: url.absoluteString as NSString)
        
        // Cache the image to file.
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        
        if let data = image.pngData() {
            try? data.write(to: fileURL)
        }
    }
    
    private func image(for url: URL) -> UIImage? {
    
        // Check the file cache.
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        
        // Try to get image from file cache and add to memory cache.
        if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
            memoryCache.setObject(image, forKey: url.absoluteString as NSString)
            return image
        }
        
        return nil
    }
    
    func fetchImage(from url: URL?) async -> UIImage? {
      
        guard let url else { return nil }
        
        // Try to get image from memory cache.
        if let cachedImage = memoryCache.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
       
        // If not in memory cache, check the file cache.
        if let cachedImage = image(for: url) {
            return cachedImage
        }
        
        // Fetch from network if image is not in any cache.
        do {
            
            let data = try await fetchImageFromNetwork(url: url)
           
            if let uiImage = UIImage(data: data) {
                cacheImage(uiImage, for: url)
                return uiImage
            }
            
        } catch {
            return nil
        }
        
        return nil
    }
    
    // Fetch data using a continuation to avoid warnings about non-Sendable types.
    private func fetchImageFromNetwork(url: URL) async throws -> Data {
       
        try await withCheckedThrowingContinuation { continuation in
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let _ = response {
                    continuation.resume(returning: (data))
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
            task.resume()
        }
    }
    
    func clearAllCaches() {

        // Clear memory cache.
        memoryCache.removeAllObjects()
        
        // Clear file cache.
        do {
            let files = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
            for file in files {
                try fileManager.removeItem(at: file)
            }
        } catch {
            // Can log the error.
            // print("Failed to clear disk cache: \(error)")
        }
    }
}
