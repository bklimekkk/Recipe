//
//  NewPDPView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 29/09/2023.
//

import SwiftUI

struct NewPDPView: View {
    var url: String
    @Binding var newMealEquipment: [Equipment]
    @Binding var newMealIngredients: [APIIngredient]
    @State private var newName = ""
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<NewRecipe>
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Circle()
                                .fill(.blue)
                        )
                }
                TextFieldModifier {
                    TextField("Enter new name", text: $newName)
            }
            }
            AsyncImage(url: URL(string: url))
                .cornerRadius(10)
            if !newMealEquipment.isEmpty {
                Text("Equipment:")
                    .bold()
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
                .bold()
            ForEach(newMealIngredients, id: \.self) { ingredient in
                ComponentModifier(content: {
                    IngredientInterface(name: ingredient.name,
                                        quantity: ingredient.amount.metric.value,
                                        unit: ingredient.amount.metric.unit)
                }, selected: false)
            }
                Button {
                 createNewRecipe()
                } label: {
                    if newName.isEmpty {
                        ButtonView(title: "Recipe name is missing", mainColor: .red)
                    } else {
                        ButtonView(title: "Save recipe", mainColor: .green)
                    }
                    
                }
                .disabled(newName.isEmpty)
        }
    }
    
    func createNewRecipe() {
        let recipe = NewRecipe(context: moc)
        recipe.name = newName
        recipe.url = url
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
    }
}
