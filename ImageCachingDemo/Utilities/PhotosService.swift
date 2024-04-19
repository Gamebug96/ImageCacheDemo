//
//  PhotosService.swift
//  ImageCachingDemo
//
//  Created by Gurditta Singh on 19/04/24.
//

import Foundation

/// Custom Error for better control over error messages
enum APIError: Error, LocalizedError {
   case invalidURL

   var errorDescription: String? {
      switch self {
      case .invalidURL:
         return "URL for request seems to invalid!"
      }
   }
}

/// Protocol for designing Photos service
protocol PhotosServiceProtocol {
   func fetchPhotos(for page: Int) async throws -> [Photo]
}

struct PhotosService: PhotosServiceProtocol {
   func fetchPhotos(for page: Int) async throws -> [Photo] {
      guard let url = URL(
         string: "https://api.unsplash.com/photos/?page=\(page)&per_page=20&client_id=\(Constants.unsplashClientID)"
      ) else {
         throw APIError.invalidURL
      }

      var request = URLRequest(url: url)
      request.addValue("application/json;version=2.0", forHTTPHeaderField: "Accept")

      do {
         let (data, _) = try await URLSession.shared.data(for: request)
         return try JSONDecoder().decode([Photo].self, from: data)
      } catch {
         throw error
      }
   }
}

/// Can be used for previews or unit testing
struct StubPhotosService: PhotosServiceProtocol {
   func fetchPhotos(for page: Int) async throws -> [Photo] {
      return [.mock(), .mock(), .mock(), .mock(), .mock()]
   }
}
