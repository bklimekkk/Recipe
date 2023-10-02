//
//  ContentView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 02/09/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<CustomRecipe>
    @Environment(\.managedObjectContext) var moc
    @State private var addNewRecipe = false
    @State private var showAlert = false
    @State private var recipeToDelete = CustomRecipe()
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach(recipes, id: \.self) { recipe in
                        NavigationLink {
                            CustomRecipeView(recipe: recipe)
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
                .padding(.horizontal, 5)
                Spacer()
                Button {
                    addNewRecipe = true
                } label: {
                    HStack {
                        Text("Add new recipe")
                            .bold()
                        Image(systemName: "plus")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                    )
                }
            }
            .alert("Are you sure to delete this recipe?",
                   isPresented: $showAlert,
                   actions: {
                Button("Yes", role: .cancel) {
                    moc.delete(recipeToDelete)
                    if moc.hasChanges {
                        try? moc.save()
                    }
                }
                Button("No", role: .destructive) {
                    
                }
            })
            .fullScreenCover(isPresented: $addNewRecipe) {
                NewRecipeView(addNewRecipe: $addNewRecipe)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State private var addNewRecipe = false
    static var previews: some View {
        ContentView()
    }
}
