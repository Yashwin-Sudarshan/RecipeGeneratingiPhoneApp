//
//  PantryUpdateIngredientViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 28/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This struct handles updating ingredient information in the core ingredient database

import Foundation

struct PantryUpdateIngredientViewModel {
    
    private var ingredientManager = DataManager.shared
    
    // Updates selected ingredient row in database and saves the update to the database
    mutating func updateIngredient(_ name: String, _ quantity: String, _ expirationDate : String, _ index: Int){
        
        ingredientManager.updateIngredient(name, quantity: quantity, expirationDate: expirationDate, index: index)
    }
}
