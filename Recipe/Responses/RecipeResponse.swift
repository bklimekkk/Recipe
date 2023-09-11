//
//  RecipeResponse.swift
//  Recipe
//
//  Created by Bartosz Klimek on 19/09/2023.
//

import Foundation

// MARK: - RecipeResults
struct RecipeResponse: Codable {
    let results: [Result]
    let offset, number, totalResults: Int
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: ImageType
}

enum ImageType: String, Codable {
    case jpg
}
