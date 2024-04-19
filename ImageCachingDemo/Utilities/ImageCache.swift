//
//  ImageCache.swift
//  ImageCachingDemo
//
//  Created by Gurditta Singh on 19/04/24.
//

import UIKit

/// This class saves and loads UIImages using `NSCache`
final class ImageCache {
   private let cache = NSCache<NSString, UIImage>()

   func set(_ image: UIImage, forKey key: String) {
      cache.setObject(image, forKey: key as NSString)
   }

   func get(forKey key: String) -> UIImage? {
      return cache.object(forKey: key as NSString)
   }
}
