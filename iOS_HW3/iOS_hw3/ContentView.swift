//
//  ContentView.swift
//  iOS_HW3
//
//  Created by user06 on 2023/10/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhoto2: PhotosPickerItem?
    @State private var selectedPhoto3: [PhotosPickerItem] = []
    @State private var image: Image?
    @State private var image2: Image?
    @State private var image3: Image?
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    image?
                        .resizable()
                        .scaledToFit()
                }.toolbar {
                    PhotosPicker(
                        selection: $selectedPhoto,
                        // limit the type of selected photos
                        matching: .images
                    ) {
                        Image(systemName: "pencil")
                    }
                }
                .task(id: selectedPhoto) {
                    image = try? await selectedPhoto?.loadTransferable(type: Image.self)
                }
                ZStack {
                    image2?
                        .resizable()
                        .scaledToFit()
                }.toolbar {
                    PhotosPicker(
                        selection: $selectedPhoto2,
                        matching: .all(of: [.screenshots, .panoramas])
                    ) {
                        Image(systemName: "heart.fill")
                    }
                }
                .task(id: selectedPhoto2) {
                    if selectedPhoto2?.supportedContentTypes.first == .image {
                        image = try? await selectedPhoto2?.loadTransferable(type: Image.self)
                    }
                }
                ZStack {
                    image3?
                        .resizable()
                        .scaledToFit()
                }.toolbar {
                    PhotosPicker(selection: $selectedPhoto3, maxSelectionCount: 3) {
                        Image(systemName: "house")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
