//
//  SearchProductResponse.swift
//  Recipe
//
//  Created by Bartosz Klimek on 20/09/2023.
//

import Foundation

// MARK: - SearchProductResponse
struct SearchProductResponse: Codable {
    let products: [Product]
    let totalProducts: Int
    let type: String
    let offset, number: Int
}

// MARK: - Product
struct Product: Hashable, Codable {
    let id: Int
    let title, imageType: String
}
