//
//  NewPDPView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 29/09/2023.
//

import SwiftUI

struct NewPDPView: View {
    var newMealEquipment: [Equipment]
    var newMealIngredients: [APIIngredient]
    @State private var newName = ""
    var body: some View {
        VStack {
            TextFieldModifier {
                TextField("Enter new name", text: $newName)
                if !newMealEquipment.isEmpty {
                    Text("Equipment:")
                    ForEach(newMealEquipment, id: \.self) { equipment in
                        ComponentModifier(content: {
                            Text(equipment.name)
                        }, selected: false)
                    }
                    
                }
                Text("Ingredients:")
                ForEach(newMealIngredients, id: \.self) { ingredient in
                    ComponentModifier(content: {
                        VStack {
                            Text(ingredient.name)
                            Divider()
                            HStack {
                                Text(ingredient.amount.metric.value.description)
                                Spacer()
                                Text(ingredient.amount.metric.unit)
                            }
                        }
                    }, selected: false)
                }
            }
            
        }
    }
}
