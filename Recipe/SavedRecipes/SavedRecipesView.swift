//
//  SavedRecipesView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 30/09/2023.
//

import SwiftUI

struct SavedRecipesView: View {
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<NewRecipe>
    @Environment(\.managedObjectContext) var moc
    @State private var recipeToDelete = NewRecipe()
    @State private var showAlert = false
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(recipes, id: \.self) { recipe in
                    NavigationLink {
                        SavedRecipeView(recipe: recipe)
                    } label: {
                        ZStack {
                            PLPMember(title: recipe.getName(), color: .gray)
                            DeletionXmark {
                               recipeToDelete = recipe
                               showAlert = true
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .padding()
            .alert("Are you sure to delete this recipe?",
                   isPresented: $showAlert) {
                Button("Yes", role: .cancel) {
                    moc.delete(recipeToDelete)
                    if moc.hasChanges {
                        try? moc.save()
                    }
                }
                Button("No", role: .destructive) {}
            }
        }
    }
}

struct DeletionXmark: View {
    var perform: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                perform()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
        }
    }
}
