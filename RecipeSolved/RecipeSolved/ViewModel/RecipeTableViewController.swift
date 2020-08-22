//
//  TableViewController.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    private let viewModel = RecipeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let imageView = cell.viewWithTag(1000) as? UIImageView
        let recipeTitle = cell.viewWithTag(1001) as? UILabel
        let recipeTime = cell.viewWithTag(1002) as? UILabel
        let recipeItems = cell.viewWithTag(1003) as? UILabel
        let recipeRating = cell.viewWithTag(1004) as? UILabel
        let recipeSteps = cell.viewWithTag(1005) as? UILabel
        
        if let imageView = imageView, let recipeTitle = recipeTitle, let recipeTime = recipeTime, let recipeItems = recipeItems, let recipeRating = recipeRating, let recipeSteps = recipeSteps{
            let currentRecipe = viewModel.getRecipe(byIndex: indexPath.row)
            imageView.image = currentRecipe.image
            recipeTitle.text = currentRecipe.title
            recipeTime.text = currentRecipe.time
            recipeItems.text = currentRecipe.items
            recipeRating.text = currentRecipe.rating
            recipeSteps.text = currentRecipe.steps
        }
        return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedRow = self.tableView.indexPathForSelectedRow else{return}
        
        let destination = segue.destination as? RecipeViewController
        
        let selectedRecipe = viewModel.getRecipe(byIndex: selectedRow.row)
        
        destination?.selectedRecipe = selectedRecipe

    }

}
