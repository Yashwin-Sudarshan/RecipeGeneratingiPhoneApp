//
//  HomeRecipeViewModel.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 1/10/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import UIKit

struct HomeRecipeViewModel {
    
    private var model = HomeAPI.shared
    
    var delegate:RefreshHome?{
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
    
    func getRandomRecipe() {
        model.getRandomRecipe()
    }
}
