//
//  Validator.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 31/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation

protocol Validator {
    
    func validatePantryInputs(ingredient: String, qty: String, exp: String) -> Bool
    
    func validateIngredient(ingredient: String) -> Bool
    
    func validateQty(qty: String) -> Bool
    
    func validateExp(exp: String) -> Bool
}
