//
//  SummaryView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 08/09/2023.
//

import SwiftUI

struct SummaryView: View {
    @Binding var recipe: Recipe
    var body: some View {
        Form {
            Section {
                TextField("Recipe name", text: $recipe.name)
            } header: {
                Text("Name")
            }
            Section {
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    HStack {
                        Text(ingredient.name)
                        Spacer()
                        Text(ingredient.quantity)
                        Text(ingredient.quantityType.rawValue)
                    }
                }
            } header: {
                Text("Ingredients")
            }
            Section {
                ForEach(recipe.steps, id: \.self) { step in
                    VStack(alignment: .leading) {
                        Text(step.name)
                        ForEach(step.ingredients, id: \.name) { ingredient in
                            Text("+ \(ingredient.name)")
                        }
                    }
                }
            } header: {
                Text("Steps")
            }
            
            if !recipe.photos.isEmpty {
                Section {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(recipe.photos, id: \.self) { photo in
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        }
                    }
                } header: {
                    Text("Photos")
                }
            }
        }
    }
}
