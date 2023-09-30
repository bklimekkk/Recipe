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

    func getName() -> String {
        return name ?? ""
    }
}

extension NewRecipe : Identifiable {

}
