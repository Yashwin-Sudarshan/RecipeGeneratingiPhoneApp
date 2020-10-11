//
//  PantryIngredientAddingViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 26/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This struct performs addition of an ingredient to the core ingredient database

import Foundation

struct PantryIngredientAddingViewModel{
    
    private var ingredientManager = DataManager.shared
    
    // Adds ingredients to the database
    mutating func addIngredient(_ name: String, _ quantity: String, _ expirationDate : String){
        
        ingredientManager.addIngredient(name, quantity: quantity, expirationDate: expirationDate)
    }
    
}
