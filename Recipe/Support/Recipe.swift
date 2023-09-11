//
//  Recipe.swift
//  My Recipe
//
//  Created by Bartosz Klimek on 02/09/2023.
//

import Foundation
import UIKit

struct Recipe {
    var name: String
    var ingredients: [Ingredient]
    var steps: [Step]
    var photos: [UIImage]
    
    init() {
        name = ""
        ingredients = []
        steps = []
        photos = []
    }
    
    init(name: String) {
        self.name = name
        ingredients = []
        steps = []
        photos = []
    }
    
    init(name: String, ingredients: [Ingredient], steps: [Step], photos: [UIImage]) {
        self.name = name
        self.ingredients = ingredients
        self.steps = steps
        self.photos = photos
    }
}

struct Ingredient: Hashable {
    var name: String
    var quantity: String
    var quantityType: QuantityType
}

struct Step: Hashable {
    var name: String
    var ingredients: [Ingredient]
    
    init() {
        self.name = ""
        self.ingredients = []
    }
    
    init(name: String, ingredients: [Ingredient]) {
        self.name = name
        self.ingredients = ingredients
    }
}

enum QuantityType: String {
    case tableSpoons = "Table Spoons",
         littleSpoons = "Little Spoons",
         glasses = "Glasses",
         pieces = "Pieces"
}
