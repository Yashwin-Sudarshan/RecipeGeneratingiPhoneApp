//
//  RecipeViewController.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var selectedRecipe:(title:String, items:String, servings:String, ingredients:String, url:String, image:UIImage?)?
    
    var recipeURL: String? = nil

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeItems: UILabel!
    @IBOutlet weak var recipeServings: UILabel!
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBAction func clickRecipeButton(_ sender: Any) {
        if let url = URL(string: selectedRecipe!.url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedRecipe = selectedRecipe {
            recipeImage.image = selectedRecipe.image
            recipeTitle.text = selectedRecipe.title
            recipeItems.text = selectedRecipe.items
            recipeServings.text = selectedRecipe.servings
            recipeIngredients.text = selectedRecipe.ingredients
        }
        
    }

}
