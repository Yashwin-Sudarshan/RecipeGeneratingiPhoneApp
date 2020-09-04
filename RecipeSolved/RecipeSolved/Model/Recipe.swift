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
    case Pasta = "Pasta", Steak = "Steak", Chips = "Chips", FruitSalad = "Fruit Salad", PumpkinSoup = "Pumpkin Soup", SteamedRice = "Steamed Rice", HardBoiledEggs = "Hard Boiled Eggs", SoftBoiledEggs = "Soft Boiled Eggs", PoachedEggs = "Poached Eggs"
    
    var imageName:String{
        switch self{
        case .Pasta: return "pasta"
        case .Steak: return "steak"
        case .Chips: return "chips"
        case .FruitSalad: return "FruitSalad"
        case .PumpkinSoup: return "PumpkinSoup"
        case .SteamedRice: return "SteamedRice"
        case .HardBoiledEggs: return "HardBoiledEgg"
        case .SoftBoiledEggs: return "SoftBoiledEgg"
        case .PoachedEggs: return "PoachedEggs"
        }
    }
    
    var recipeTime:String{
        switch self{
        case .Pasta: return "30 mins"
        case .Steak: return "20 mins"
        case .Chips: return "40 mins"
        case .FruitSalad: return "10 mins"
        case .PumpkinSoup: return "70 mins"
        case .SteamedRice: return "20 mins"
        case .HardBoiledEggs: return "6-8 mins"
        case .SoftBoiledEggs: return "4-6 mins"
        case .PoachedEggs: return "3 mins"
        }
    }
    
    var recipeItems:String{
        switch self{
        case .Pasta: return "2 items"
        case .Steak: return "5 items"
        case .Chips: return "3 items"
        case .FruitSalad: return "2-4 items"
        case .PumpkinSoup: return "5 items"
        case .SteamedRice: return "1 items"
        case .HardBoiledEggs: return "1 item"
        case .SoftBoiledEggs: return "1 item"
        case .PoachedEggs: return "2 items"
        }
    }
    
    var recipeRating:String{
        switch self{
        case .Pasta: return "4.5 stars"
        case .Steak: return "3.5 stars"
        case .Chips: return "4 stars"
        case .FruitSalad: return "5 stars"
        case .PumpkinSoup: return "4 stars"
        case .SteamedRice: return "5 stars"
        case .HardBoiledEggs: return "4 stars"
        case .SoftBoiledEggs: return "3 stars"
        case .PoachedEggs: return "4 stars"
        }
    }
    
    var recipeIngredients:String{
        switch self{
        case .Pasta: return "Ingredients:\n- Pasta of your choice\n- Salt"
        case .Steak: return "Ingredients:\n- Steak of your choice\n- Olive Oil\n- Garlic\n- Butter\n- Thyme"
        case .Chips: return "Ingredients:\n- Potatoes\n- Salt\n- Olive Oil"
        case .FruitSalad: return "Ingredients:\n- Fruits of your choice. Examples include: bananas, apples, oranges, etc.\n- Sugar (Optional)"
        case .PumpkinSoup: return "Ingredients:\n- Pumpkin\n- Onion\n- Leek\n- Chicken Stock\n- Sour Cream (Optional)"
        case .SteamedRice: return "Ingredients:\n- Rice of your choice"
        case .HardBoiledEggs: return "Ingredients:\n- Eggs"
        case .SoftBoiledEggs: return "Ingredients:\n- Eggs"
        case .PoachedEggs: return "Ingredients:\n- Eggs\n- White Vinegar"
        }
    }
    
    var recipeSteps:String{
        switch self{
        case .Pasta: return "Steps:\n1. Boil a pot full of water which includes salt to taste. It is recommended 500ml of water per 100grams of pasta\n2. After approximately 7 minutes of boiling, sample a strand of your pasta by letting it cool and then tasting it. If the taste is at al dente, take the pasta off heat.\n3. Once removed from heat, strain pasta from water, and let it steam dry.\n4. Mix with sauce of your choice"
        case .Steak: return "Steps:\n1. Grab a medium sized pan and put a table spoon of oil, or as much as you feel is needed\n2. Once the oil has heated up, place your chosen steak on the pan \n3. As the steak is searing, add butter, garlic and thyme and continuously baste until the steak is at the correct level of cooked for your tasting"
        case .Chips: return "Steps:\n1. Peel potatoes and slice them into log wedges\n2. Place the potatos in a saucepan of water and bring it to boil\n3. Once cooked, drain the potatoes, and place them into another pan which is heated with Olive Oil \n4. Deep fry the potatos until golden \n5. Drain the potatoes on paper towel."
        case .FruitSalad: return "Steps:\n1. Choose a minimum of 3 fruits that are your favourite\n2. Peel the skin off the fruits, and dice into larger cubes\n3. Place all together in a bowl. If you have a sweet tooth, sprinkle some sugar over the top"
        case .PumpkinSoup: return "Steps:\n1. Heat oil in a large sauce pan over low heat\n2. Add onion, leek and any other flavourings you enjoy, and cook for 2-3 minutes until softened \n3. Add garlic and nutmeg and cook for 30 seconds\n4. Add the pumpkin and chicken stock and bring to boil\n5. Turn heat low, cover and simmer for 20-30 minutes\n6. Depending on the size of your blender, place a portion of the mix in the blender, and puree\n7. Add to bowls and serve, adding sour cream as a personal preference"
        case .SteamedRice: return "Steps:\n1. Rince rice in cold water until it runs clear, then drain\n2. Bring rice and 4 cups of water to a boil in a pot for 5-7 minutes. Do not stir\n3. Reduce heat, then cover pot and allow rice to simmer for 15 minutes\n4. Remove from heat and strain. It is now ready for serving"
        case .HardBoiledEggs: return "Steps:\n1. Place egg(s) in a pot or sauce pan with enough water to cover the contents. Make sure they are covered by a minimum of an inch\n2. Heat the pot on high heat to bring the water to boil. Once boiling, continue at this heat for 6-8 minutes, depending on how cooked you like the yolk\n3. Turn off stove, and move pot to sink. Pour out the water, and allow cold water to run over the eggs\n4. Once cool enough to touch, peel the eggs disposing of the shell in the bin"
        case .SoftBoiledEggs: return "Steps:\n1. Place egg(s) in a pot or sauce pan with enough water to cover the contents. Make sure they are covered by a minimum of an inch\n2. Heat the pot on high heat to bring the water to boil. Once boiling, continue at this heat for 3-5 minutes, depending on how soft you like the yolk\n3. Turn off stove, and move pot to sink. Pour out the water, and allow cold water to run over the eggs\n4. Once cool enough to touch, use a spoon to carefully remove the top of the egg"
        case .PoachedEggs: return "Steps:\n1. Bring a pan of water atleast 2 inch deep to simmer on stove\n2. Add a drop of white vinegar to the water\n3. Stir water to create a gentle whirlpool in the centre\n4. Crack egg into centre\n5. Cook for 3-4 minutes until set\n6. Remove the egg from the pan with a slotted spoon"
        }
    }
}
