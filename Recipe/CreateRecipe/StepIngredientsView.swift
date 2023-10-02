//
//  StepIngredientsView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 02/10/2023.
//

import SwiftUI

struct StepIngredientsView: View {
    var ingredients: [CustomIngredient]
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(ingredients, id: \.self) { ingredient in
                PLPMember(title: ingredient.getName(), color: .blue)
            }
        }
        .padding(.horizontal, 5)
        .navigationTitle("Step ingredients")
    }
}
