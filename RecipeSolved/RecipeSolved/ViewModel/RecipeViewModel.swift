//
//  ExploreViewModel.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import UIKit

struct RecipeViewModel{
    private (set) var recipes:[Recipe] = []
    
    var count:Int{
        return recipes.count
    }
    
    init(){
        loadData()
    }
    
    private mutating func loadData(){
        recipes.append(Recipe.Pasta)
        recipes.append(Recipe.Steak)
        recipes.append(Recipe.Chips)
    }
    
    func getRecipe(byIndex index: Int) -> (title:String, time:String, items:String, rating:String, steps:String, image:UIImage?){
        let title = recipes[index].rawValue
        let time = recipes[index].recipeTime
        let items = recipes[index].recipeItems
        let rating = recipes[index].recipeRating
        let steps = recipes[index].recipeSteps
        let image = UIImage(named: recipes[index].imageName)
        
        return (title, time, items, rating, steps, image)
    }
}
