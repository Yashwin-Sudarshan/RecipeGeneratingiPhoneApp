//
//  Validation.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This class handles user input validation for the pantry adding and editing scenes. Validation is
// currently performed using regular expressions. An ingredient name must only contain letters, a
// quantity can be either be a discrete number for number of items, or a weight in grams, or a
// capacity in litres.


import Foundation

class PantryValidator: Validator{
    
    func validateIngredient(ingredient:String) -> Bool{
        
//        let ingredRegex = "[a-zA-z][a-zA-z]*"
        let ingredRegex = "^[a-zA-z_]+( [a-zA-Z_]+)*$"
        let trimmedEntryString = ingredient.trimmingCharacters(in: .whitespaces)
        let validateIngredient = NSPredicate(format: "SELF MATCHES %@", ingredRegex)
        let isValidateIngredient = validateIngredient.evaluate(with: trimmedEntryString)
        return isValidateIngredient
    }
    
    func validateQty(qty:String) -> Bool{
        
        let qtyRegex = "(^[1-9][0-9]*[g])|([1-9][0-9]*[L])|([0-9][.][1-9]*[L])|([0-9][.][0][0]*[1-9][1-9]*[0-9]*[1-9][L])|([0-9][.][0][0]*[1-9][1-9]*[L])|([1-9][0-9]*[.][0][0]*[1-9][1-9]*[0-9]*[1-9][L])|([1-9][0-9]*[.][0][0]*[1-9][1-9]*[L])|([1-9][0-9]*[.][0]*[1-9][1-9]*[L])|([1-9][0-9]*[m][L])|([1-9][0-9]*|\0)"
        let trimmedEntryString = qty.trimmingCharacters(in: .whitespaces)
        let validateQty = NSPredicate(format: "SELF MATCHES %@", qtyRegex)
        let isValidateQty = validateQty.evaluate(with: trimmedEntryString)
        return isValidateQty
    }
    
//    func validateExp(exp:String) -> Bool{
//
//        let expRegex = "^((0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\\/((0[1-9])|(1[0-2]))"
//        let trimmedEntryString = exp.trimmingCharacters(in: .whitespaces)
//        let validateExp = NSPredicate(format: "SELF MATCHES %@", expRegex)
//        let isValidateExp = validateExp.evaluate(with: trimmedEntryString)
//        return isValidateExp
//    }
    
    // Validates all inputs (ingredient field, quantity field, expiry field)
    func validatePantryInputs(ingredient: String, qty: String) -> Bool {
    
//        return validateIngredient(ingredient: ingredient) && validateQty(qty: qty) && validateExp(exp: exp)
        return validateIngredient(ingredient: ingredient) && validateQty(qty: qty)
    }
}
