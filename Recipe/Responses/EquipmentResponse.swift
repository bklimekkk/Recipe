//
//  EquipmentResponse.swift
//  Recipe
//
//  Created by Bartosz Klimek on 20/09/2023.
//

import Foundation

// MARK: - EquipmentResponse
struct EquipmentResponse: Hashable, Codable {
    let equipment: [Equipment]
}

// MARK: - Equipment
struct Equipment: Hashable, Codable {
    let image, name: String
}
