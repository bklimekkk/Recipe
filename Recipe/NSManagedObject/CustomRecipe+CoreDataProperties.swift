//
//  CustomRecipe+CoreDataProperties.swift
//  Recipe
//
//  Created by Bartosz Klimek on 02/10/2023.
//
//

import Foundation
import CoreData


extension CustomRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomRecipe> {
        return NSFetchRequest<CustomRecipe>(entityName: "CustomRecipe")
    }

    @NSManaged public var name: String?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var steps: NSSet?
    @NSManaged public var photos: NSSet?

    func getName() -> String {
        return name ?? ""
    }
}

// MARK: Generated accessors for ingredients
extension CustomRecipe {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: CustomIngredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: CustomIngredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

// MARK: Generated accessors for steps
extension CustomRecipe {

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: CustomStep)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: CustomStep)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)

}

// MARK: Generated accessors for photos
extension CustomRecipe {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: CustomPhoto)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: CustomPhoto)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}

extension CustomRecipe : Identifiable {

}
