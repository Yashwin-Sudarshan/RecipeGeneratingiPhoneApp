//
//  TableViewController.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class RecipeTableViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    private let viewModel = RecipeViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    var filteredRecipes:[Recipe] = []
    var allRecipes:[Recipe] = []
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        var request = REST_API()
        request.getRecipe(ingredients: "", title: "Chicken")
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Add all of the recipes to the allRecipes array
        for recipe in 0..<viewModel.count {
            allRecipes.append(viewModel.getRecipeType(byIndex: recipe))
        }
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        // Add Search bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Recipes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }

    // Find the number of rows based on whether we are currently searching for something or not
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredRecipes.count
        }
        
        return allRecipes.count
    }

    // Draw the table depending on whether we are currently searching for something or not
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let imageView = cell.viewWithTag(1000) as? UIImageView
        let recipeTitle = cell.viewWithTag(1001) as? UILabel
        let recipeTime = cell.viewWithTag(1002) as? UILabel
        let recipeItems = cell.viewWithTag(1003) as? UILabel
        let recipeRating = cell.viewWithTag(1004) as? UILabel
        
        if let imageView = imageView, let recipeTitle = recipeTitle, let recipeTime = recipeTime, let recipeItems = recipeItems, let recipeRating = recipeRating{
            if isFiltering {
                let currentRecipe = viewModel.getRecipeByRecipe(byRecipe: filteredRecipes[indexPath.row])
                imageView.image = currentRecipe.image
                recipeTitle.text = currentRecipe.title
                recipeTime.text = currentRecipe.time
                recipeItems.text = currentRecipe.items
                recipeRating.text = currentRecipe.rating
            } else {
                let currentRecipe = viewModel.getRecipeByRecipe(byRecipe: allRecipes[indexPath.row])
                imageView.image = currentRecipe.image
                recipeTitle.text = currentRecipe.title
                recipeTime.text = currentRecipe.time
                recipeItems.text = currentRecipe.items
                recipeRating.text = currentRecipe.rating
            }
        }
        return cell
    }
    
    // Filter the table depending on what is being searched for
    func filterContentForSearchText(_ searchText: String) {
        var recipeStrings:[String] = []
        for recipe in 0..<allRecipes.count {
            let currentRecipe = viewModel.getRecipeByRecipe(byRecipe: allRecipes[recipe])
            recipeStrings.append(currentRecipe.title)
            recipeStrings.append(currentRecipe.time)
            recipeStrings.append(currentRecipe.items)
            recipeStrings.append(currentRecipe.rating)
            recipeStrings.append(currentRecipe.ingredients)
            recipeStrings.append(currentRecipe.steps)
        }
        
        let filteredResults = recipeStrings.filter {$0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchText.replacingOccurrences(of: " ", with: "").lowercased())
        }
        
        var filteredRecipesSearch:[Recipe] = []
        for recipe in 0..<allRecipes.count {
            let currentRecipe = viewModel.getRecipeByRecipe(byRecipe: allRecipes[recipe])
            if filteredResults.contains(currentRecipe.title) {
                filteredRecipesSearch.append(allRecipes[recipe])
            }
        }
        
        filteredRecipes = filteredRecipesSearch
        
        tableView.reloadData()
    }

    // When you click on a table cell, go to the RecipeViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard
            let indexPath = tableView.indexPathForSelectedRow,
            let recipeViewController = segue.destination as? RecipeViewController
            else {
                return
        }
        
        if isFiltering {
            let selectedRecipe = viewModel.getRecipeByRecipe(byRecipe: filteredRecipes[indexPath.row])
            recipeViewController.selectedRecipe = selectedRecipe
        } else {
            let selectedRecipe = viewModel.getRecipeByRecipe(byRecipe: allRecipes[indexPath.row])
            recipeViewController.selectedRecipe = selectedRecipe
        }

    }

}

// Update search result based on what the user is searching for
extension RecipeTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
}
