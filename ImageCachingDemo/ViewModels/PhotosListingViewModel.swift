//
//  PhotosListingViewModel.swift
//  ImageCachingDemo
//
//  Created by Gurditta Singh on 18/04/24.
//

import SwiftUI

@MainActor
final class PhotosListingViewModel: ObservableObject {
   let photosService: PhotosServiceProtocol

   @Published private(set) var photos = [Photo]()
   @Published private(set) var isLoading = false
   @Published private(set) var errorMessage: String?

   private var currentPage = 1 // Default value is 1 for the API

   init(photosService: PhotosServiceProtocol) {
      self.photosService = photosService
   }

   func fetchPhotos() {
      isLoading = true
      Task {
         do {
            let photos = try await photosService.fetchPhotos(for: currentPage)
            self.photos.append(contentsOf: photos)
         } catch {
            errorMessage = error.localizedDescription
         }
         isLoading = false
      }
   }

   func fetchMorePhotos() {
      currentPage += 1
      fetchPhotos()
   }
}

// MARK: - Routing

extension PhotosListingViewModel {
   struct Routing {
      var errorMessage: String?
   }
}
