//
//  Pantry+CoreDataProperties.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 24/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//
//

import Foundation
import CoreData


extension Pantry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pantry> {
        return NSFetchRequest<Pantry>(entityName: "Pantry")
    }

    @NSManaged public var ingredients: NSSet?

}

// MARK: Generated accessors for ingredients
extension Pantry {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}
