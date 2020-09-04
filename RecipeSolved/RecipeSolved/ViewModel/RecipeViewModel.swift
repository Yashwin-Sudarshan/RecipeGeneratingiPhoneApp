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
    
    weak var searchView: UIView!
    
    var searchController: UISearchController!
    var currentDataSourceSearch:[Recipe] = []
    
    
    var count:Int{
        return recipes.count
    }
    
    //let searchController = UISearchController(searchResultsController: nil)
    
    
    init(){
        loadData()
    }
    
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
        currentDataSourceSearch = recipes
        
    }
    
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
    
    func getRecipeType(byIndex index: Int) -> (Recipe){
        return recipes[index]
    }
    
//    func getRecipeViewModel() -> (RecipeViewModel){
//        return self
//    }
}

