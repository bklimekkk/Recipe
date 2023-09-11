//
//  UserResponse.swift
//  Recipe
//
//  Created by Bartosz Klimek on 21/09/2023.
//

import Foundation

struct User: Codable {
    let username: String
    let firstName: String
    let lastName: String
    let email: String
}

struct UserResponse: Codable {
    let username: String
    let spoonacularPassword: String
    let hash: String
}
