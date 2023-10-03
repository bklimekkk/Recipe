//
//  SavedRecipeView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 30/09/2023.
//

import SwiftUI

struct SavedRecipeView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    var recipe: NewRecipe
    var lastElement: Bool {
        recipe.equipment?.count == 0 && recipe.ingredients?.count == 0
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            AsyncImage(url: URL(string: recipe.getUrl()))
                .cornerRadius(10)
            if recipe.equipment?.count ?? 0 > 0 {
                Text("Equipment:")
                    .bold()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(recipe.equipment as? Set<NewEquipment> ?? []), id: \.self) { equipment in
                        Menu {
                            Button("Delete") {
                                moc.delete(equipment)
                                if moc.hasChanges {
                                    try? moc.save()
                                }
                                dismiss()
                            }
                        } label: {
                            ComponentModifier(content: {
                                Text(equipment.getName())
                                    .foregroundColor(.white)
                            }, selected: false)
                        }
                    }
                }
            }
            if recipe.ingredients?.count ?? 0 > 0 {
                Text("Ingredients:")
                    .bold()
            }
            ForEach(Array(recipe.ingredients as? Set<NewIngredient> ?? []), id: \.self) { ingredient in
                Menu {
                    Button("Delete") {
                        moc.delete(ingredient)
                        if moc.hasChanges {
                            try? moc.save()
                        }
                        dismiss()
                    }
                } label: {
                    ComponentModifier(content: {
                        IngredientInterface(name: ingredient.getName(),
                                            quantity: ingredient.quantity,
                                            unit: ingredient.getUnit())
                    }, selected: false)
                    
                }
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
