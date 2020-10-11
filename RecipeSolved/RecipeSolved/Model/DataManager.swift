//
//  DataManager.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 26/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This class handles direct addition of ingredients and developers into the ingredient and developer databases, updating of ingredients, and deletion of ingredients, and loading of ingredients and developers

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
    
    // Updates an ingredient at the selected row in the database and saves the update
    func updateIngredient(_ name: String, quantity: String, expirationDate: String, index: Int){
        
        ingredients[index].name = name
        ingredients[index].quantity = quantity
        ingredients[index].expirationDate = expirationDate
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // Deletes an ingredient at the selected row in the database and saves the deletion update
    func deleteIngredient(index: Int){
        
        managedContext.delete(ingredients[index])
        ingredients.remove(at: index)
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
