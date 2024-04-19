//
//  ImageLoader.swift
//  ImageCachingDemo
//
//  Created by Gurditta Singh on 19/04/24.
//

import SwiftUI

/// Custom image downloader for caching images
final class ImageLoader: ObservableObject {
   @Published var image: UIImage?

   private let urlSession: URLSession
   private let imageCache: ImageCache

   /// Initializer with default values
   /// - Parameters:
   ///   - urlSession: URL Session for downloading image
   ///   - imageCache: For caching and providing cached images
   init(
      urlSession: URLSession = URLSession.shared,
      imageCache: ImageCache = ImageCache()
   ) {
      self.urlSession = urlSession
      self.imageCache = imageCache
   }

   /// This function provides a cached image if available
   /// otherwise loads a new one using URLSession
   /// - Parameter urlString: URL string for the image
   @MainActor func loadImage(_ urlString: String) async {
      if let cachedImage = imageCache.get(forKey: urlString) {
         self.image = cachedImage
         return
      }

      guard let url = URL(string: urlString) else { return }

      do {
         let (data, _) = try await urlSession.data(from: url)
         image = UIImage(data: data)
         if let image {
            self.imageCache.set(image, forKey: urlString)
         }
      } catch {
         print("Error while retreiving image: \(error.localizedDescription)")
      }
   }
}
