//
//  CustomRecipeView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 02/10/2023.
//

import SwiftUI

struct CustomRecipeView: View {
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
            }
        }
        .navigationTitle(recipe.getName())
    }
}
