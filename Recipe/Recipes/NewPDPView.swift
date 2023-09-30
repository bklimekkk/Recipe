//
//  NewPDPView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 29/09/2023.
//

import SwiftUI

struct NewPDPView: View {
    @Binding var newMealEquipment: [Equipment]
    @Binding var newMealIngredients: [APIIngredient]
    @State private var newName = ""
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<NewRecipe>
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextFieldModifier {
                TextField("Enter new name", text: $newName)
            }
            if !newMealEquipment.isEmpty {
                Text("Equipment:")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(newMealEquipment, id: \.self) { equipment in
                            ComponentModifier(content: {
                                Text(equipment.name)
                                    .foregroundColor(.white)
                            }, selected: false)
                        }
                    }
                }
            }
            Text("Ingredients:")
            ForEach(newMealIngredients, id: \.self) { ingredient in
                ComponentModifier(content: {
                    IngredientInterface(name: ingredient.name,
                                        quantity: ingredient.amount.metric.value,
                                        unit: ingredient.amount.metric.unit)
                }, selected: false)
            }
            if !newName.isEmpty {
                Button {
                    let recipe = NewRecipe(context: moc)
                    recipe.name = newName
                    newMealEquipment.forEach { equipment in
                        let newEquipment = NewEquipment(context: moc)
                        newEquipment.name = equipment.name
                        recipe.addToEquipment(newEquipment)
                    }
                    newMealIngredients.forEach { ingredient in
                        let newIngredient = NewIngredient(context: moc)
                        newIngredient.name = ingredient.name
                        newIngredient.quantity = ingredient.amount.metric.value
                        newIngredient.unit = ingredient.amount.metric.unit
                        recipe.addToIngredients(newIngredient)
                    }
                    if moc.hasChanges {
                        try? moc.save()
                    }
                    newMealEquipment.removeAll()
                    newMealIngredients.removeAll()
                    dismiss()
                } label: {
                    ButtonView(title: "Save recipe")
                }
            }
        }
    }
}
