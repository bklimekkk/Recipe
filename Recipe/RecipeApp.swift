//
//  RecipeApp.swift
//  Recipe
//
//  Created by Bartosz Klimek on 11/09/2023.
//

import SwiftUI

@main
struct RecipeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
