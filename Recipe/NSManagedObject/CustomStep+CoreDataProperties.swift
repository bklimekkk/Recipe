//
//  CustomStep+CoreDataProperties.swift
//  Recipe
//
//  Created by Bartosz Klimek on 02/10/2023.
//
//

import Foundation
import CoreData


extension CustomStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomStep> {
        return NSFetchRequest<CustomStep>(entityName: "CustomStep")
    }

    @NSManaged public var name: String?
    @NSManaged public var recipe: CustomRecipe?
    @NSManaged public var ingredients: NSSet?

    func getName() -> String {
        return name ?? ""
    }
}

// MARK: Generated accessors for ingredients
extension CustomStep {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: CustomIngredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: CustomIngredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension CustomStep : Identifiable {

}
