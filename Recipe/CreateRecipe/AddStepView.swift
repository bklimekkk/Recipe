//
//  AddStepView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 03/09/2023.
//

import SwiftUI

struct AddStepView: View {
    @Binding var recipe: Recipe
    @State private var step = Step()
    @Environment(\.dismiss) var dismiss
    
    var duplicateStep: Bool {
        recipe.steps.contains(step)
    }
    
    var body: some View {
        VStack {
            TextFieldModifier {
                TextField("Enter step", text: $step.name)
            }
            if !step.name.isEmpty {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(recipe.ingredients, id: \.name) { ingredient in
                        HStack {
                            Spacer()
                            Text(ingredient.name)
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(step.ingredients.contains(ingredient) ? .green : .blue)
                        )
                        .onTapGesture {
                            if !step.ingredients.contains(ingredient) {
                                step.ingredients.append(ingredient)
                            } else {
                                step.ingredients.removeAll(where: { $0.name == ingredient.name })
                            }
                        }
                    }
                }
            }
            Spacer()
            if !step.name.isEmpty {
                Button {
                    recipe.steps.append(step)
                    dismiss()
                } label: {
                    ButtonView(title: "Add Step", duplicate: duplicateStep)
                }
                .disabled(duplicateStep)
            }
        }
        .padding()
    }
}
