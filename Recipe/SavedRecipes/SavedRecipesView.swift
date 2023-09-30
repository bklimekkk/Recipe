//
//  SavedRecipesView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 30/09/2023.
//

import SwiftUI

struct SavedRecipesView: View {
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<NewRecipe>
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(recipes, id: \.self) { recipe in
                    NavigationLink {
                        SavedRecipeView(recipe: recipe)
                    } label: {
                        PLPMember(title: recipe.getName())
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SavedRecipesView()
}
