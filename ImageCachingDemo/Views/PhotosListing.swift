//
//  PhotosListing.swift
//  ImageCachingDemo
//
//  Created by Gurditta Singh on 18/04/24.
//

import SwiftUI

struct PhotosListing: View {
   @StateObject var viewModel: PhotosListingViewModel

   private let contentWidth: CGFloat = UIScreen.main.bounds.width/2 - 30
   private let contentHeight: CGFloat = UIScreen.main.bounds.width/2 - 30

   var body: some View {
      content()
         .padding(.horizontal, 25)
         .navigationTitle("Unsplash")
         .onAppear(perform: {
            viewModel.fetchPhotos()
         })
   }

   // MARK: - Displaying Content

   @ViewBuilder
   private func content() -> some View {
      ZStack {
         imagesList()
         if viewModel.photos.isEmpty, viewModel.isLoading {
            ProgressView()
         }
      }
   }

   @ViewBuilder
   private func imagesList() -> some View {
      let gridItems = [GridItem(.flexible()), GridItem(.flexible())]

      ScrollView(showsIndicators: false) {
         LazyVGrid(columns: gridItems, content: {
            ForEach(viewModel.photos) { photo in
               imageView(photo)
                  .onAppear(perform: {
                     if photo == viewModel.photos.last {
                        viewModel.fetchMorePhotos()
                     }
                  })
            }
         })
      }
   }

   private func imageView(_ photo: Photo) -> some View {
      CachedImageView(url: photo.thumbnailURL ?? "")
         .frame(width: contentWidth, height: contentHeight)
         .scaledToFill()
         .clipShape(RoundedRectangle(cornerRadius: 10))
   }
}

#Preview {
   NavigationStack {
      PhotosListing(viewModel: .init(photosService: StubPhotosService()))
   }
}
