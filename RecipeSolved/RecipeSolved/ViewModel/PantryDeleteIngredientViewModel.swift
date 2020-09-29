//
//  PantryDeleteIngredientViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 28/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import UIKit

struct PantryDeleteIngredientViewModel{
    
    private var ingredientManager = DataManager.shared
    
    // Deletes an ingredient from the specified row in the core database and saves the deletion
    mutating func deleteIngredient(_ index: Int){
        
        ingredientManager.deleteIngredient(index: index)
    }
}
