//
//  StepsView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 03/09/2023.
//

import SwiftUI

struct StepsView: View {
    @Binding var recipe: Recipe
    @State private var showAddStepView = false
    var body: some View {
        VStack {
            if recipe.steps.isEmpty {
                EmptyView(title: "No Steps")
            } else {
                VStack {
                    ScrollView(showsIndicators: false) {
                        ForEach(recipe.steps, id: \.self) { step in
                            VStack {
                                ListMember {
                                    HStack {
                                        Text(step.name)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                }
                                ForEach(step.ingredients, id: \.name) { ingredient in
                                    HStack {
                                        Text("+ \(ingredient.name)")
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(.blue)
                                    )
                                }
                            }
                        }
                    }
                    Spacer()
                    NavigationLink {
                        PhotosView(recipe: $recipe)
                    } label: {
                        ButtonView(title: "Photos")
                    }
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $showAddStepView, content: {
            AddStepView(recipe: $recipe)
        })
        .navigationTitle(recipe.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddStepView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ListMember<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        content()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
            )
    }
}
