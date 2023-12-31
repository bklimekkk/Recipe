//
//  NewRecipeView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 02/09/2023.
//

import SwiftUI

struct NewRecipeView: View {
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<CustomRecipe>
    @Binding var addNewRecipe: Bool
    @State private var recipe = Recipe()
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    TextFieldModifier {
                        TextField("Recipe name", text: $recipe.name)
                    }
                    Spacer()
                }
                Text("Existing names:")
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(recipes, id: \.self) { recipe in
                            HalfScreenComponent {
                                HStack {
                                    Spacer()
                                    Text(recipe.getName())
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 5)
                Spacer()
                if !recipe.name.isEmpty && !recipes.map({ $0.name }).contains(recipe.name) {
                    NavigationLink {
                        IngredientsView(recipe: $recipe)
                    } label: {
                        ButtonView(title: "Ingredients", mainColor: .blue)
                            .padding(.bottom)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        addNewRecipe = false
                    } label: {
                        Text("Back to recipes")
                    }
                }
            }
        }
    }
}

struct TextFieldModifier<Content:View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.ultraThinMaterial)
            )
    }
}

struct ComponentModifier<Content: View>: View {
    var content: () -> Content
    var selected: Bool
    
    init(@ViewBuilder content: @escaping() -> Content, selected: Bool) {
        self.content = content
        self.selected = selected
    }
    
    var body: some View {
        content()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(selected ? .blue : .gray)
                    .shadow(radius: 2)
            )
            .padding(5)
    }
}

struct HalfScreenComponent<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping() -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
        .foregroundColor(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue)
        )
    }
}

struct ButtonView: View {
    var title: String
    var mainColor: Color
    var duplicate = false
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(duplicate ? .gray : mainColor)
            )
    }
}
