//
//  NewRecipe+CoreDataProperties.swift
//  Recipe
//
//  Created by Bartosz Klimek on 30/09/2023.
//
//

import Foundation
import CoreData


extension NewRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewRecipe> {
        return NSFetchRequest<NewRecipe>(entityName: "NewRecipe")
    }

    @NSManaged public var name: String?
    @NSManaged public var equipment: NSSet?
    @NSManaged public var ingredients: NSSet?

    func getName() -> String {
        return name ?? ""
    }
}

// MARK: Generated accessors for equipment
extension NewRecipe {

    @objc(addEquipmentObject:)
    @NSManaged public func addToEquipment(_ value: NewEquipment)

    @objc(removeEquipmentObject:)
    @NSManaged public func removeFromEquipment(_ value: NewEquipment)

    @objc(addEquipment:)
    @NSManaged public func addToEquipment(_ values: NSSet)

    @objc(removeEquipment:)
    @NSManaged public func removeFromEquipment(_ values: NSSet)

}

// MARK: Generated accessors for ingredients
extension NewRecipe {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: NewIngredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: NewIngredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension NewRecipe : Identifiable {

}
