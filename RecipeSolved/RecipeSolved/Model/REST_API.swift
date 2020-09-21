//
//  REST_API.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation

struct REST_API{
    private var recipes:[Recipe] = []
    
    private let session = URLSession.shared
    
    private let baseURL:String = "https://api.edamam.com/search?"
    private let query:String = "q="
    private let appID:String = "&app_id=94e40056"
    private let key:String = "&app_key=abcb68e252eb783c822d980b7b68a30f"
    
    mutating func getRecipe(ingredients:String, title: String){
        recipes = []
        let url = baseURL + query + title + appID + key
        
        guard let url_format = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        if let url = URL(string: url_format){
            let request = URLRequest(url: url)
            getData(request, element: "hits")
        }
    }
    
    private func getData(_ request: URLRequest, element: String){
        let task = session.dataTask(with: request, completionHandler: {
            data, response, downloadError in
            
            if let error = downloadError{
                print(error)
            }
            else{
                var parsedResult: Any! = nil
                do{
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                }catch{print()}
                let result = parsedResult as! [String:Any]
                
                // print to console, remove when testing is completed
                print(result)
                
                
            }
        })
        task.resume()
    }
}
