//
//  REST_API.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation

protocol Refresh {
    func updateUI()
}

class REST_API {
    private var _recipes:[Recipe] = []
    var delegate:Refresh?
    private let session = URLSession.shared
    
    // URL parameters
    private let baseURL:String = "https://api.edamam.com/search?"
    private let query:String = "q="
    private let appID:String = "&app_id=94e40056"
    private let key:String = "&app_key=abcb68e252eb783c822d980b7b68a30f"
    
    var recipes:[Recipe]{
        return _recipes
    }
    
    // Pass in a string to this function, which will then pass that string to the API.
    func getRecipe(title: String) {
        _recipes = []
        let url = baseURL + query + title + appID + key
        
        guard let url_format = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        if let url = URL(string: url_format) {
            let request = URLRequest(url: url)
            getData(request, element: "hits")
        }
    }
    
    // Get Data from the API and populate the recipes array.
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
                        let image = jsonRecipe["image"] as! String
                        let url = jsonRecipe["url"] as! String
                        let yield = jsonRecipe["yield"] as! Float
                        let servings = "Serves " + String(yield.clean)
                        let ingredientLines = jsonRecipe["ingredientLines"] as! Array<String>
                        let items = String(ingredientLines.count) + " ingredients"
                        let commaSeperatedIngredients = ingredientLines.joined(separator: ",")
                        let ingredients = commaSeperatedIngredients.replacingOccurrences(of: ",", with: "\n")
                        
                        let recipe = Recipe(title: title, image: image, url: url, servings: servings, items: items, ingredients: ingredients)
                        self._recipes.append(recipe)
                    }
                }
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
            }
        })
        task.resume()
    }
    
    private init(){}
    static let shared = REST_API()
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
