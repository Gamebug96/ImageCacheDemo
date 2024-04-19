//
//  Photo.swift
//  ImageCachingDemo
//
//  Created by Gurditta Singh on 18/04/24.
//

import Foundation

struct Photo: Codable, Identifiable, Equatable {
   /// Keys for image url in the urls dictionary
   enum ImageData: String, Codable {
      case raw
      case full
      case regular
      case small
      case thumb
   }

   let id: String
   let urls: [String: String]

   var thumbnailURL: String? {
      urls[ImageData.thumb.rawValue]
   }
}

extension Photo {
   static func mock() -> Self {
      .init(
         id: UUID().uuidString,
         urls: ["thumb": "https://images.unsplash.com/photo-1709733615343-3de3d6f79ac0?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w1OTE5MDZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTM1MTI3NTZ8\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=200"]
      )
   }
}
