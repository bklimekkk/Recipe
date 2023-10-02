//
//  CustomIngredient+CoreDataProperties.swift
//  Recipe
//
//  Created by Bartosz Klimek on 02/10/2023.
//
//

import Foundation
import CoreData


extension CustomIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomIngredient> {
        return NSFetchRequest<CustomIngredient>(entityName: "CustomIngredient")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Double
    @NSManaged public var unit: String?
    @NSManaged public var recipe: CustomRecipe?
    @NSManaged public var step: CustomStep?

    func getName() -> String {
        return name ?? ""
    }
    
    func getUnit() -> String {
        return unit ?? ""
    }
}

extension CustomIngredient : Identifiable {

}
