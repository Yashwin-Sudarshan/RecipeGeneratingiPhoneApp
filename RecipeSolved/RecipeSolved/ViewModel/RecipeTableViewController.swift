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
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    var currentDataSourceSearch:[Recipe] = []
    var allRecipes:[Recipe] = []
//    var searchRecipes:[Recipe] = []
//    var recipeStrings:[String] = []
//    var filteredRecipes:[Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
//        for recipe in 0..<viewModel.count {
//            let currentRecipe = viewModel.getRecipe(byIndex: recipe)
//            searchRecipes.append(currentRecipe.title)
//            searchRecipes.append(currentRecipe.time)
//            searchRecipes.append(currentRecipe.items)
//            searchRecipes.append(currentRecipe.rating)
//            searchRecipes.append(currentRecipe.steps)
//        }
        
        for recipe in 0..<viewModel.count {
            allRecipes.append(viewModel.getRecipeType(byIndex: recipe))
        }
        
        currentDataSourceSearch = allRecipes
        
//        currentDataSourceSearch = viewModel
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDataSourceSearch.count
    }

  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let imageView = cell.viewWithTag(1000) as? UIImageView
        let recipeTitle = cell.viewWithTag(1001) as? UILabel
        let recipeTime = cell.viewWithTag(1002) as? UILabel
        let recipeItems = cell.viewWithTag(1003) as? UILabel
        let recipeRating = cell.viewWithTag(1004) as? UILabel
        let recipeSteps = cell.viewWithTag(1005) as? UILabel
        
        if let imageView = imageView, let recipeTitle = recipeTitle, let recipeTime = recipeTime, let recipeItems = recipeItems, let recipeRating = recipeRating, let recipeSteps = recipeSteps{
            let currentRecipe = viewModel.getRecipeByRecipe(byRecipe: currentDataSourceSearch[indexPath.row])
            imageView.image = currentRecipe.image
            recipeTitle.text = currentRecipe.title
            recipeTime.text = currentRecipe.time
            recipeItems.text = currentRecipe.items
            recipeRating.text = currentRecipe.rating
            recipeSteps.text = currentRecipe.steps
        }
        return cell
    }
    
    func filterCurrentDataSourceSearch(searchTerm: String){
        
        if searchTerm.count > 0{
            
//            for recipe in 0..<viewModel.count {
//                currentDataSourceSearch.append(viewModel.getRecipeType(byIndex: recipe))
//            }
            
            var recipeStrings:[String] = []
            for recipe in 0..<currentDataSourceSearch.count {
                let currentRecipe = viewModel.getRecipeByRecipe(byRecipe: currentDataSourceSearch[recipe])
                recipeStrings.append(currentRecipe.title)
                recipeStrings.append(currentRecipe.time)
                recipeStrings.append(currentRecipe.items)
                recipeStrings.append(currentRecipe.rating)
                recipeStrings.append(currentRecipe.steps)
            }
            
            let filteredResults = recipeStrings.filter {$0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
            }
            
            var filteredRecipes:[Recipe] = []
            for recipe in 0..<currentDataSourceSearch.count {
                let currentRecipe = viewModel.getRecipeByRecipe(byRecipe: currentDataSourceSearch[recipe])
                if filteredResults.contains(currentRecipe.title) {
                    filteredRecipes.append(currentDataSourceSearch[recipe])
                }
            }
            
            currentDataSourceSearch = filteredRecipes
            tableView.reloadData()
        }
        else{
            restoreCurrentDataSourceSearch()
        }
    }
    
    func restoreCurrentDataSourceSearch(){
        
        currentDataSourceSearch = allRecipes
        
        tableView.reloadData()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedRow = self.tableView.indexPathForSelectedRow else{return}
        
        let destination = segue.destination as? RecipeViewController
        
        let selectedRecipe = viewModel.getRecipe(byIndex: selectedRow.row)
        
        destination?.selectedRecipe = selectedRecipe

    }

}

extension RecipeTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            currentDataSourceSearch.remove(at: indexPath.row)
            
//            PantryIngredientaddingViewController.ingredInput.remove(at: indexPath.row)
            
            for recipe in 0..<viewModel.count {
                currentDataSourceSearch.append(viewModel.getRecipeType(byIndex: recipe))
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchValText = searchController.searchBar.text{
            filterCurrentDataSourceSearch(searchTerm: searchValText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        
        if let searchValText = searchBar.text{
            filterCurrentDataSourceSearch(searchTerm: searchValText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        
        if let searchValText = searchBar.text, !searchValText.isEmpty{
            restoreCurrentDataSourceSearch()
        }
    }
}
