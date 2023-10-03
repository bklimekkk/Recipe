//
//  PDPView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 19/09/2023.
//

import SwiftUI

struct PDPView: View {
    var name: String
    var id: Int
    var url: String
    @State private var mealEquipment: [Equipment] = []
    @State private var newMealEquipment: [Equipment] = []
    @State private var mealIngredients: [APIIngredient] = []
    @State private var newMealIngredients: [APIIngredient] = []
    @State private var showNewPDP = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                AsyncImage(url: URL(string: url))
                    .cornerRadius(10)
                Text("Equipment:")
                    .bold()
                if mealEquipment.isEmpty {
                    ProgressView()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(mealEquipment, id: \.self) { equipment in
                                ComponentModifier(content: {
                                    Text(equipment.name)
                                        .foregroundColor(.white)
                                }, selected: newMealEquipment.contains(equipment))
                                .onTapGesture {
                                    if newMealEquipment.contains(equipment) {
                                        newMealEquipment.removeAll(where: {$0 == equipment })
                                    } else {
                                        newMealEquipment.append(equipment)
                                    }
                                }
                            }
                        }
                    }
                }
                Text("Ingredients:")
                    .bold()
                if mealIngredients.isEmpty {
                    ProgressView()
                } else {
                    ForEach(mealIngredients, id: \.self) { ingredient in
                        ComponentModifier(content: {
                            IngredientInterface(name: ingredient.name,
                                                quantity: ingredient.amount.metric.value,
                                                unit: ingredient.amount.metric.unit)
                        }, selected: newMealIngredients.contains(ingredient))
                        .onTapGesture {
                            if newMealIngredients.contains(ingredient) {
                                newMealIngredients.removeAll(where: { $0 == ingredient })
                            } else {
                                newMealIngredients.append(ingredient)
                            }
                        }
                    }
                }
            }
            if !newMealIngredients.isEmpty {
                VStack {
                    Spacer()
                    Button {
                        showNewPDP = true
                    } label: {
                        ButtonView(title: "Create recipe", mainColor: .green)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            Repository.getEquipment(id: id) { equipment in
                mealEquipment = equipment ?? []
            }
            Repository.getIngredients(id: id, completion: { ingredients in
                mealIngredients = ingredients ?? []
            })
        }
        .navigationTitle(name)
        .fullScreenCover(isPresented: $showNewPDP, content: {
            NewPDPView(url: url, newMealEquipment: $newMealEquipment,
                       newMealIngredients: $newMealIngredients)
        })
    }
}
