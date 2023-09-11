//
//  PhotosView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 09/09/2023.
//

import SwiftUI

struct PhotosView: View {
    @Binding var recipe: Recipe
    @State private var photo: UIImage?
    @State private var showPhotoView = false
    var body: some View {
        VStack {
            if recipe.photos.isEmpty {
                Text("No photos")
                    .bold()
                    .font(.system(size: 40))
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(recipe.photos, id: \.self) { photo in
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        }
                    }
                }
            }
            NavigationLink {
                SummaryView(recipe: $recipe)
            } label: {
                ButtonView(title: "Summary")
            }
        }
        .padding(.horizontal, 5)
        .fullScreenCover(isPresented: $showPhotoView, onDismiss: {
            if let photo = photo {
                recipe.photos.append(photo)
            }
        }) {
            ImagePicker(image: $photo, showPhotoView: $showPhotoView)
                .ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showPhotoView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
