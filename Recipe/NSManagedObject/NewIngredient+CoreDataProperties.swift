//
//  NewIngredient+CoreDataProperties.swift
//  Recipe
//
//  Created by Bartosz Klimek on 30/09/2023.
//
//

import Foundation
import CoreData


extension NewIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewIngredient> {
        return NSFetchRequest<NewIngredient>(entityName: "NewIngredient")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Double
    @NSManaged public var unit: String?
    @NSManaged public var newRecipe: NewRecipe?

    func getName() -> String {
        return name ?? ""
    }
    
    func getUnit() -> String {
        return unit ?? ""
    }
}

extension NewIngredient : Identifiable {

}
