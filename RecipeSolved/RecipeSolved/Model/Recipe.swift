//
//  Recipes.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
enum Recipe:String
{
    case Pasta = "Pasta", Steak = "Steak", Chips = "Chips"
    
    var imageName:String{
        switch self{
        case .Pasta: return "pasta"
        case .Steak: return "steak"
        case .Chips: return "chips"
        }
    }
    
    var recipeTime:String{
        switch self{
        case .Pasta: return "30 mins"
        case .Steak: return "20 mins"
        case .Chips: return "40 mins"
        }
    }
    
    var recipeItems:String{
        switch self{
        case .Pasta: return "4 items"
        case .Steak: return "3 items"
        case .Chips: return "2 items"
        }
    }
    
    var recipeRating:String{
        switch self{
        case .Pasta: return "4.5 stars"
        case .Steak: return "3.5 stars"
        case .Chips: return "4 stars"
        }
    }
    
    var recipeSteps:String{
        switch self{
        case .Pasta: return "Steps:\n1. Something\n2. Something else"
        case .Steak: return "Steps:\n1. Something\n2. Something else"
        case .Chips: return "Steps:\n1. Something\n2. Something else"
        }
    }
}
