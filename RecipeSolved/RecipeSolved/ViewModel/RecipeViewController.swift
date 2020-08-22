//
//  RecipeViewController.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var selectedRecipe:(title:String, time:String, items:String, rating:String, steps:String, image:UIImage?)?

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeItems: UILabel!
    @IBOutlet weak var recipeRating: UILabel!
    @IBOutlet weak var recipeSteps: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedRecipe = selectedRecipe {
            recipeImage.image = selectedRecipe.image
            recipeTitle.text = selectedRecipe.title
            recipeTime.text = selectedRecipe.time
            recipeItems.text = selectedRecipe.items
            recipeRating.text = selectedRecipe.rating
            recipeSteps.text = selectedRecipe.steps
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
