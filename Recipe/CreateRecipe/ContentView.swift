//
//  ContentView.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 02/09/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var addNewRecipe = false
    var body: some View {
        VStack {
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
            Spacer()
        }
        .fullScreenCover(isPresented: $addNewRecipe) {
            NewRecipeView(addNewRecipe: $addNewRecipe)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State private var addNewRecipe = false
    static var previews: some View {
        ContentView()
    }
}
