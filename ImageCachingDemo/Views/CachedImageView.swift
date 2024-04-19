//
//  CachedImageView.swift
//  ImageCachingDemo
//
//  Created by Gurditta Singh on 19/04/24.
//

import SwiftUI

/// A view which downloads the image and caches it internally
@MainActor
struct CachedImageView: View {
   @StateObject var imageLoader: ImageLoader
   let url: String

   /// Initializer for the view where a testing loader can be passed
   /// - Parameters:
   ///   - imageLoader: Loads and caches the image
   ///   - url: URL String for the image
   init(
      imageLoader: ImageLoader = ImageLoader(),
      url: String
   ) {
      self._imageLoader = .init(wrappedValue: imageLoader)
      self.url = url
   }

   var body: some View {
      content()
         .task {
            await imageLoader.loadImage(url)
         }
   }

   // MARK: - Displaying Content

   @ViewBuilder
   private func content() -> some View {
      if let image = imageLoader.image {
         Image(uiImage: image)
            .resizable()
      } else {
         ProgressView()
      }
   }
}
