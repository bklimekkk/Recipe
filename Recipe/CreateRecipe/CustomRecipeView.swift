//
//  CustomRecipeView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 02/10/2023.
//

import SwiftUI

struct CustomRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    var recipe: CustomRecipe
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                Text("Ingredients:")
                    .bold()
                ForEach(Array(recipe.ingredients as? Set<CustomIngredient> ?? []), id: \.self) { ingredient in
                    ComponentModifier(content: {
                        IngredientInterface(name: ingredient.getName(),
                                            quantity: ingredient.quantity,
                                            unit: ingredient.getUnit())
                    }, selected: false)
                }
                Text("Steps:")
                    .bold()
                ForEach(Array(recipe.steps as? Set<CustomStep> ?? []), id: \.self) { step in
                    NavigationLink {
                        StepIngredientsView(ingredients: Array(step.ingredients as? Set<CustomIngredient> ?? []))
                    } label: {
                        PLPMember(title: step.getName(), color: .gray)
                            .padding(.horizontal, 5)
                    }
                }
                if recipe.photos?.count ?? 0 > 0 {
                    Text("Photos:")
                        .bold()
                }
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(Array(recipe.photos as? Set<CustomPhoto> ?? []), id: \.self) { photo in
                        NavigationLink {
                            Image(uiImage: UIImage(data: photo.image ?? Data()) ?? UIImage())
                                .resizable()
                                .scaledToFill()
                                .navigationTitle(photo.getDate())
                        } label: {
                            ZStack {
                                Image(uiImage: UIImage(data: photo.image ?? Data()) ?? UIImage())
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                
                                Button {
                                    recipe.removeFromPhotos(photo)
                                    if moc.hasChanges {
                                        try? moc.save()
                                    }
                                    dismiss()
                                } label: {
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Image(systemName: "xmark")
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
                .padding(.horizontal, 5)
            }
        }
        .navigationTitle(recipe.getName())
    }
}
