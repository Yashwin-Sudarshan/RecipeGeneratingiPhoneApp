//
//  DataManager.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 26/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataManager{
    
    static let shared = DataManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext: NSManagedObjectContext
    
    // Collection of developers
    private (set) var developers:[Developer] = []
    
    //Collection of ingredients
    private (set) var ingredients:[Ingredient] = []
    
    private init(){
        
        managedContext = appDelegate.persistentContainer.viewContext
        loadDevelopers()
//        deleteDevelopers()
        loadIngredients()
    }
    
    // Creates new Ingredient
    private func createNSIngredient(_ name: String, quantity: String, expirationDate : String) -> Ingredient{
        
        let ingredientEntity = NSEntityDescription.entity(forEntityName: "Ingredient", in: managedContext)!
        
        let nsIngredient = NSManagedObject(entity: ingredientEntity, insertInto: managedContext) as! Ingredient
        
        nsIngredient.setValue(name, forKeyPath: "name")
        nsIngredient.setValue(quantity, forKeyPath: "quantity")
        nsIngredient.setValue(expirationDate, forKeyPath: "expirationDate")
        
        return nsIngredient
    }
    
    // Creates new Developer
    private func createNSDeveloper(_ name: String, image: UIImage, developerBio: String) -> Developer{
        
        let developerEntity = NSEntityDescription.entity(forEntityName: "Developer", in: managedContext)!
        
        let nsDeveloper = NSManagedObject(entity: developerEntity, insertInto: managedContext) as! Developer
        
        nsDeveloper.setValue(name, forKeyPath: "name")
        nsDeveloper.setValue(developerBio, forKeyPath: "developerBio")
        
        let data = UIImagePNGRepresentation(image) as NSData?
        nsDeveloper.image = data
        
        return nsDeveloper
    }
    
    // Adds new developer to developer database
    func addDeveloper(_ name: String, _ image: UIImage, _ developerBio : String){
        
//        let nsAuthor = createNSAuthor(author)
        let nsDeveloper = createNSDeveloper(name, image: image, developerBio: developerBio)
        developers.append(nsDeveloper)
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // Adds new ingredient to ingredient database
    func addIngredient(_ name: String, quantity: String, expirationDate : String){
        
        let nsIngredient = createNSIngredient(name, quantity: quantity, expirationDate: expirationDate)
        ingredients.append(nsIngredient)
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // Read saved developers from database
    private func loadDevelopers(){
        
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Developer")
            
            let result = try managedContext.fetch(fetchRequest)
            developers = result as! [Developer]
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // Just for testing purposes --> to be removed later
    private func deleteDevelopers(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Developer")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // get reference to the persistent container
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    // Read saved ingredients from database
    private func loadIngredients(){
        
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
            
            let result = try managedContext.fetch(fetchRequest)
            ingredients = result as! [Ingredient]
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
