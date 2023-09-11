//
//  IngredientsResponse.swift
//  Recipe
//
//  Created by Bartosz Klimek on 19/09/2023.
//

import Foundation

// MARK: - IngredientsResponse
struct IngredientsResponse: Codable {
    let ingredients: [APIIngredient]
}

// MARK: - Ingredient
struct APIIngredient: Codable, Hashable {
    let amount: Amount
    let image, name: String
}

// MARK: - Amount
struct Amount: Codable, Hashable {
    let metric, us: Metric
}

// MARK: - Metric
struct Metric: Codable, Hashable {
    let unit: String
    let value: Double
}
