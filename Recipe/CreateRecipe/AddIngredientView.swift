//
//  AddIngredientView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 03/09/2023.
//

import SwiftUI

struct AddIngredientView: View {
    @Binding var recipe: Recipe
    @State private var ingredient = Ingredient(name: "", quantity: "", quantityType: .tableSpoons)
    @Environment(\.dismiss) var dismiss
    
    var duplicateIngredient: Bool {
        recipe.ingredients.map { $0.name }.contains(ingredient.name)
    }
    
    var body: some View {
        VStack {
            TextFieldModifier {
                TextField("Enter name", text: $ingredient.name)
            }
            TextFieldModifier {
                TextField("Enter quantity", text: $ingredient.quantity)
                    .keyboardType(.decimalPad)
            }
            Menu(ingredient.quantityType.rawValue) {
                Button("Table Spoons") {
                    ingredient.quantityType = .tableSpoons
                }
                Button("Little Spoons") {
                    ingredient.quantityType = .littleSpoons
                }
                Button("Glasses") {
                    ingredient.quantityType = .glasses
                }
                Button("Pieces") {
                    ingredient.quantityType = .pieces
                }
            }
            Spacer()
            if !ingredient.name.isEmpty && !ingredient.quantity.isEmpty {
                Button {
                    recipe.ingredients.append(ingredient)
                    dismiss()
                } label: {
                    Text("Add Ingredient")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(duplicateIngredient ? .gray : .blue)
                        )
                }
                .disabled(duplicateIngredient)
            }
        }
        .padding()
    }
}
