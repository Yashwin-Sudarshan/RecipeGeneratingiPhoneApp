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
    var currentDataSourceSearch:[String] = []
    var recipes1:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        currentDataSourceSearch = recipes1
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
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
    
    func filterCurrentDataSourceSearch(searchTerm: String){
        
        if searchTerm.count > 0{
            
            currentDataSourceSearch = recipes1
            
            let filteredResults = currentDataSourceSearch.filter {$0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
                
            }
            currentDataSourceSearch = filteredResults
            tableView.reloadData()
        }
        else{
            restoreCurrentDataSourceSearch()
        }
    }
    
    func restoreCurrentDataSourceSearch(){
        
        currentDataSourceSearch = recipes1
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
            recipes1.remove(at: indexPath.row)
            
            PantryIngredientaddingViewController.ingredInput.remove(at: indexPath.row)
            
            currentDataSourceSearch = recipes1
            
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
