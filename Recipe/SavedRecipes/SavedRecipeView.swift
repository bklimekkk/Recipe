//
//  SavedRecipeView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 30/09/2023.
//

import SwiftUI

struct SavedRecipeView: View {
    var recipe: NewRecipe
    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(recipe.equipment as? Set<NewEquipment> ?? []), id: \.self) { equipment in
                        ComponentModifier(content: {
                            Text(equipment.getName())
                                .foregroundColor(.white)
                        }, selected: false)
                    }
                }
            }
            ForEach(Array(recipe.ingredients as? Set<NewIngredient> ?? []), id: \.self) { ingredient in
                ComponentModifier(content: {
                    IngredientInterface(name: ingredient.getName(),
                                        quantity: ingredient.quantity,
                                        unit: ingredient.getUnit())
                }, selected: false)
            }
        }
        .padding(.horizontal, 5)
        .navigationTitle(recipe.getName())
    }
}

struct IngredientInterface: View {
    var name: String
    var quantity: Double
    var unit: String
    var body: some View {
        VStack {
            Group {
                Text(name)
                Divider()
                HStack {
                    Text(String(quantity))
                    Spacer()
                    Text(unit)
                }
            }
            .foregroundColor(.white)
        }
    }
}
