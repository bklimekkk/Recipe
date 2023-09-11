//
//  RecipesView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 13/09/2023.
//

import SwiftUI

struct RecipesView: View {
    @State private var recipes: [Result] = []
    var body: some View {
        NavigationStack {
            VStack {
                if recipes.isEmpty {
                    ProgressView()
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(recipes, id: \.title) { recipe in
                            NavigationLink {
                                PDPView(name: recipe.title, id: recipe.id, url: recipe.image)
                            } label: {
                                PLPMember(title: recipe.title)
                            }
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                fetchRecipes()
            }
        }
    }
    
    func fetchRecipes() {
        if let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(Constants.apiKey)") {
            let session = URLSession.shared
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                
                guard(200...299).contains(httpResponse.statusCode) else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                    recipes = recipeResponse.results
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            task.resume()
        }
    }
}

struct PLPMember: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
        }
        .buttonStyle(.plain)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
        )
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
