//
//  ExploreViewModel.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import UIKit

struct RecipeViewModel {
    
    private var model = REST_API.shared
    
    var delegate:Refresh?{
        get {
            return model.delegate
        }
        set (value) {
            model.delegate = value
        }
    }
    
    var count:Int{
        return recipes.count
    }
    
    var recipes:[Recipe]{
        return model.recipes
    }
    
    func getTitleFor(index:Int) -> String {
        return recipes[index].title
    }
    
    func getImageFor(index:Int) -> UIImage? {
        let url = recipes[index].image
        guard let imageURL = URL(string: url) else {
            return nil
        }
        let data = try? Data(contentsOf: imageURL)
        let image: UIImage? = nil
        if let imageData = data {
            return UIImage(data: imageData)
        }
        return image
    }
    
    func getURLFor(index:Int) -> String {
        return recipes[index].url
    }
    
    func getServingsFor(index:Int) -> String {
        return recipes[index].servings
    }
    
    func getItemsFor(index:Int) -> String {
        return recipes[index].items
    }
    
    func getIngredientsFor(index:Int) -> String {
        return recipes[index].ingredients
    }
    
    func getTimeFor(index:Int) -> String {
        return recipes[index].time
    }
    
    func getAllFor(index:Int) -> (title:String, items:String, servings:String, ingredients:String, url:String, image:UIImage?) {
        let title = getTitleFor(index: index)
        let items = getItemsFor(index: index)
        let servings = getServingsFor(index: index)
        let ingredients = getIngredientsFor(index: index)
        let url = getURLFor(index: index)
        let image = getImageFor(index: index)
        
        return (title, items, servings, ingredients, url, image)
    }
    
    func getRecipe(title:String) {
        model.getRecipe(title: title)
    }
}


//class RecipeViewModel{
//    private (set) var recipes:[Recipe] = []
//
//    // Returns the number of recipes in the recipes array
//    var count:Int{
//        return recipes.count
//    }
//
//    init(){
//        loadData()
//    }
//
//    // Add recipes to the recipes array
//    private func loadData(){
////        recipes.append(Recipe.Pasta)
////        recipes.append(Recipe.Steak)
////        recipes.append(Recipe.Chips)
////        recipes.append(Recipe.SteamedRice)
////        recipes.append(Recipe.FruitSalad)
////        recipes.append(Recipe.PumpkinSoup)
////        recipes.append(Recipe.HardBoiledEggs)
////        recipes.append(Recipe.SoftBoiledEggs)
////        recipes.append(Recipe.PoachedEggs)
//    }
//
//    // Return all of the recipe's parameteres based on an index
//    func getRecipe(byIndex index: Int) -> (title:String, time:String, items:String, rating:String, ingredients:String, steps:String, image:UIImage?){
////        let title = recipes[index].rawValue
////        let time = recipes[index].recipeTime
////        let items = recipes[index].recipeItems
////        let rating = recipes[index].recipeRating
////        let ingredients = recipes[index].recipeIngredients
////        let steps = recipes[index].recipeSteps
////        let image = UIImage(named: recipes[index].imageName)
//
//        let title = "Pasta"
//        let time = "30 mins"
//        let items = "3"
//        let rating = "4.5"
//        let ingredients = "Pasta\nWater"
//        let steps = "Step 1. Boil water.\nStep 2. Cook Pasta."
//        let image = UIImage(named: "pasta")
//
//        return (title, time, items, rating, ingredients, steps, image)
//    }
//
//    // Return all of the recipe's parameters based on the recipe
//    func getRecipeByRecipe(byRecipe recipe: Recipe) -> (title:String, time:String, items:String, rating:String, ingredients:String, steps:String, image:UIImage?){
////        let title = recipe.rawValue
////        let time = recipe.recipeTime
////        let items = recipe.recipeItems
////        let rating = recipe.recipeRating
////        let ingredients = recipe.recipeIngredients
////        let steps = recipe.recipeSteps
////        let image = UIImage(named: recipe.imageName)
//
//        let title = "Pasta"
//        let time = "30 mins"
//        let items = "3"
//        let rating = "4.5"
//        let ingredients = "Pasta\nWater"
//        let steps = "Step 1. Boil water.\nStep 2. Cook Pasta."
//        let image = UIImage(named: "pasta")
//
//        return (title, time, items, rating, ingredients, steps, image)
//    }
//
//    // Returns a recipe by the index of the recipe array
//    func getRecipeType(byIndex index: Int) -> (Recipe){
//        return recipes[index]
//    }
//
//}
//
