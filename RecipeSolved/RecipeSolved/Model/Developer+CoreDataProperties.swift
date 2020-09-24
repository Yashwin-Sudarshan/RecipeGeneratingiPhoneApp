//
//  Developer+CoreDataProperties.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 24/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//
//

import Foundation
import CoreData


extension Developer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Developer> {
        return NSFetchRequest<Developer>(entityName: "Developer")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: NSData?
    @NSManaged public var developerBio: String?

}
