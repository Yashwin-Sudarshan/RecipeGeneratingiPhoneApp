//
//  Validation.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation

class Validation{
    
    public func validateIngredient(ingredient:String) -> Bool{
        
        let ingredRegex = "^\\w{1,15}$"
        let trimmedEntryString = ingredient.trimmingCharacters(in: .whitespaces)
        let validateIngredient = NSPredicate(format: "SELF MATCHES %@", ingredRegex)
        let isValidateIngredient = validateIngredient.evaluate(with: trimmedEntryString)
        return isValidateIngredient
    }
    
    public func validateQty(qty:String) -> Bool{
        
        let qtyRegex = "[0-9][0-9]*"
        let trimmedEntryString = qty.trimmingCharacters(in: .whitespaces)
        let validateQty = NSPredicate(format: "SELF MATCHES %@", qtyRegex)
        let isValidateQty = validateQty.evaluate(with: trimmedEntryString)
        return isValidateQty
    }
    
    public func validateExp(exp:String) -> Bool{
        
        let expRegex = "^((0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\\/((0[1-9])|(1[0-2]))"
        let trimmedEntryString = exp.trimmingCharacters(in: .whitespaces)
        let validateExp = NSPredicate(format: "SELF MATCHES %@", expRegex)
        let isValidateExp = validateExp.evaluate(with: trimmedEntryString)
        return isValidateExp
    }
}
