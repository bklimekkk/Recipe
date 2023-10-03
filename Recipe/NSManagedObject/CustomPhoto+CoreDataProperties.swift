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
    @NSManaged public var date: Date?
    @NSManaged public var recipe: CustomRecipe?

    func getImage() -> Data {
        return image ?? Data()
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date ?? Date())
        return dateString
    }
}

extension CustomPhoto : Identifiable {

}
