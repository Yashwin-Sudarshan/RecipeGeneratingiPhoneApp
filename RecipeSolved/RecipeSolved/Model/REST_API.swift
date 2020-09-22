//
//  REST_API.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation

class REST_API {
    private var recipes:[Recipe] = []
    
    private let session = URLSession.shared
    
    private let baseURL:String = "https://api.edamam.com/search?"
    private let query:String = "q="
    private let appID:String = "&app_id=94e40056"
    private let key:String = "&app_key=abcb68e252eb783c822d980b7b68a30f"
    
    func getRecipe(ingredients:String, title: String) {
        recipes = []
        let url = baseURL + query + title + appID + key
        
        guard let url_format = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        if let url = URL(string: url_format) {
            let request = URLRequest(url: url)
            getData(request, element: "hits")
        }
    }
    
    private func getData(_ request: URLRequest, element: String) {
        let task = session.dataTask(with: request, completionHandler: {
            data, response, downloadError in
            
            if let error = downloadError {
                print(error)
            }
            else {
                var parsedResult: Any! = nil
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                } catch { print() }
                let result = parsedResult as! [String:Any]
                
                let allRecipes = result["hits"] as! [[String:Any]]
                
                if allRecipes.count > 0 {
                    for recipe in allRecipes {
                        let jsonRecipe = recipe["recipe"] as! [String: AnyObject]
                        let title = jsonRecipe["label"] as! String
//                        print(title)
                        let image = jsonRecipe["image"] as! String
//                        print(image)
                        let url = jsonRecipe["url"] as! String
//                        print(url)
                        let yield = jsonRecipe["yield"] as! Int
                        let servings = "Serves " + String(yield)
//                        print(servings)
                        let ingredientLines = jsonRecipe["ingredientLines"] as! Array<String>
                        let items = String(ingredientLines.count) + " items"
//                        print(items)
                        let commaSeperatedIngredients = ingredientLines.joined(separator: ",")
                        let ingredients = commaSeperatedIngredients.replacingOccurrences(of: ",", with: "\n")
//                        print(ingredients)
                        
                        let recipe = Recipe(title: title, image: image, url: url, servings: servings, items: items, ingredients: ingredients)
                        self.recipes.append(recipe)
//                        print()
                    }
                }
            }
        })
        task.resume()
    }
}
