//
//  ContentView.swift
//  ImageCachingDemo
//
//  Created by Gurditta Singh on 17/04/24.
//

import SwiftUI

struct ContentView: View {
   var body: some View {
      NavigationStack {
         PhotosListing(viewModel: .init(photosService: PhotosService()))
      }
   }
}

#Preview {
   ContentView()
}
