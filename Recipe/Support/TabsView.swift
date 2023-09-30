//
//  TabsView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 13/09/2023.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("My recipes")
                }
            RecipesView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Recipes")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                 }
            SavedRecipesView()
                .tabItem {
                    Image(systemName: "list.star")
                    Text("Saved Recipes")
                }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
