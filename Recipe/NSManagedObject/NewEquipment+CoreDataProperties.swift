//
//  NewEquipment+CoreDataProperties.swift
//  Recipe
//
//  Created by Bartosz Klimek on 30/09/2023.
//
//

import Foundation
import CoreData


extension NewEquipment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewEquipment> {
        return NSFetchRequest<NewEquipment>(entityName: "NewEquipment")
    }

    @NSManaged public var name: String?
    @NSManaged public var newRecipe: NewRecipe?

    func getName() -> String {
        return name ?? ""
    }
}

extension NewEquipment : Identifiable {

}
