//
//  SummaryView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 08/09/2023.
//

import SwiftUI

struct SummaryView: View {
    @Binding var recipe: Recipe
    @Environment(\.managedObjectContext) var moc
    @State private var saved = false
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
            Button {
                saveCustomRecipe()
                saved = true
            } label: {
                if saved {
                    Text("Saved")
                } else {
                    Text("Save recipe")
                }
            }
            .disabled(saved)
        }
    }
    
    func saveCustomRecipe() {
        let customRecipe = CustomRecipe(context: moc)
        customRecipe.name = recipe.name
        recipe.ingredients.forEach { ingredient in
            let customIngredient = CustomIngredient(context: moc)
            customIngredient.name = ingredient.name
            customIngredient.quantity = Double(ingredient.quantity) ?? 0
            customIngredient.unit = ingredient.quantityType.rawValue
            customRecipe.addToIngredients(customIngredient)
        }
        recipe.steps.forEach { step in
            let customStep = CustomStep(context: moc)
            customStep.name = step.name
            step.ingredients.forEach { ingredient in
                let customIngredient = CustomIngredient(context: moc)
                customIngredient.name = ingredient.name
                customIngredient.quantity = Double(ingredient.quantity) ?? 0
                customIngredient.unit = ingredient.quantityType.rawValue
                customStep.addToIngredients(customIngredient)
            }
            customRecipe.addToSteps(customStep)
        }
        recipe.photos.forEach { photo in
            let customPhoto = CustomPhoto(context: moc)
            customPhoto.image = photo.pngData()
            customRecipe.addToPhotos(customPhoto)
        }
        if moc.hasChanges {
            try? moc.save()
        }
    }
}
