//
//  PantryIngredientAddingViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 26/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import UIKit

struct PantryIngredientAddingViewModel{
    
    private var ingredientManager = DataManager.shared
    
    // Might be redundant --> transform for display to view?
    var ingredientNames: String{
        
        var result: String = ""
        let ingredients = ingredientManager.ingredients
        for(_, ingredient) in ingredients.enumerated(){

            if let name = ingredient.name{
                result += name + "\n"
            }
        }
        return result
    }
    
    // Adds ingredients to the database
    mutating func addIngredient(_ name: String, _ quantity: String, _ expirationDate : String){
        
        ingredientManager.addIngredient(name, quantity: quantity, expirationDate: expirationDate)
    }
    
}
