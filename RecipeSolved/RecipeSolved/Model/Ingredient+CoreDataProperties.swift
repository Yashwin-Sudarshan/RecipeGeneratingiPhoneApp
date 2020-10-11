//
//  Ingredient+CoreDataProperties.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 24/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//
//

// This auto generated class contains fetchRequest setup for retrieval of an ingredient, and contains ingredient information

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: String?
    @NSManaged public var expirationDate: String?

}
