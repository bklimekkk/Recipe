//
//  CustomPhoto+CoreDataProperties.swift
//  Recipe
//
//  Created by Bartosz Klimek on 02/10/2023.
//
//

import Foundation
import CoreData


extension CustomPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomPhoto> {
        return NSFetchRequest<CustomPhoto>(entityName: "CustomPhoto")
    }

    @NSManaged public var image: Data?
    @NSManaged public var recipe: CustomRecipe?

    func getImage() -> Data {
        return image ?? Data()
    }
}

extension CustomPhoto : Identifiable {

}
