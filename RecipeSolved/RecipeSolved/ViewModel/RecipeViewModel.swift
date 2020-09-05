//
//  ExploreViewModel.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import UIKit


class RecipeViewModel{
    private (set) var recipes:[Recipe] = []
    
    // Returns the number of recipes in the recipes array
    var count:Int{
        return recipes.count
    }
    
    init(){
        loadData()
    }
    
    // Add recipes to the recipes array
    private func loadData(){
        recipes.append(Recipe.Pasta)
        recipes.append(Recipe.Steak)
        recipes.append(Recipe.Chips)
        recipes.append(Recipe.SteamedRice)
        recipes.append(Recipe.FruitSalad)
        recipes.append(Recipe.PumpkinSoup)
        recipes.append(Recipe.HardBoiledEggs)
        recipes.append(Recipe.SoftBoiledEggs)
        recipes.append(Recipe.PoachedEggs)
    }
    
    // Return all of the recipe's parameteres based on an index
    func getRecipe(byIndex index: Int) -> (title:String, time:String, items:String, rating:String, ingredients:String, steps:String, image:UIImage?){
        let title = recipes[index].rawValue
        let time = recipes[index].recipeTime
        let items = recipes[index].recipeItems
        let rating = recipes[index].recipeRating
        let ingredients = recipes[index].recipeIngredients
        let steps = recipes[index].recipeSteps
        let image = UIImage(named: recipes[index].imageName)
        
        return (title, time, items, rating, ingredients, steps, image)
    }
    
    // Return all of the recipe's parameters based on the recipe
    func getRecipeByRecipe(byRecipe recipe: Recipe) -> (title:String, time:String, items:String, rating:String, ingredients:String, steps:String, image:UIImage?){
        let title = recipe.rawValue
        let time = recipe.recipeTime
        let items = recipe.recipeItems
        let rating = recipe.recipeRating
        let ingredients = recipe.recipeIngredients
        let steps = recipe.recipeSteps
        let image = UIImage(named: recipe.imageName)
        
        return (title, time, items, rating, ingredients, steps, image)
    }
    
    // Returns a recipe by the index of the recipe array
    func getRecipeType(byIndex index: Int) -> (Recipe){
        return recipes[index]
    }
    
}

