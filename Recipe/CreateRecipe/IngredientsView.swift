//
//  IngredientsView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 02/09/2023.
//

import SwiftUI

struct IngredientsView: View {
    @Binding var recipe: Recipe
    @State private var showAddIngredient = false
    var body: some View {
        VStack {
            if recipe.ingredients.isEmpty {
                EmptyView(title: "No Ingredients")
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(recipe.ingredients, id: \.name) { ingredient in
                        ListMember {
                            HStack {
                                Group {
                                    Text(ingredient.name)
                                    Spacer()
                                    Text(ingredient.quantity)
                                    Text(ingredient.quantityType.rawValue)
                                }
                                .foregroundColor(.white)
                            }
                        }
                    }
                }
                Spacer()
                NavigationLink {
                    StepsView(recipe: $recipe)
                } label: {
                    ButtonView(title: "Steps")
                        .padding(.bottom)
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle(recipe.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddIngredient = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddIngredient) {
            AddIngredientView(recipe: $recipe)
        }
    }
}

struct EmptyView: View {
    var title: String
    var body: some View {
        Text(title)
            .bold()
            .font(.system(size: 40))
    }
}
