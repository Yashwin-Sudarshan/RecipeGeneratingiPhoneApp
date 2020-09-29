//
//  Validator.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 31/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This protocol provides a template for validating user inputs in regards to pantry items,
// as the user needs to input an ingrdient name, quantity, and expiration date when adding
// an ingredient to their pantry.

import Foundation

protocol Validator {
    
//    func validatePantryInputs(ingredient: String, qty: String, exp: String) -> Bool
    func validatePantryInputs(ingredient: String, qty: String) -> Bool
    
    func validateIngredient(ingredient: String) -> Bool
    
    func validateQty(qty: String) -> Bool
    
//    func validateExp(exp: String) -> Bool
}
