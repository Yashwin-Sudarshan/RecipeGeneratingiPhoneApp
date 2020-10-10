//
//  PantryUpdateIngredViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 19/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This view controller retrieves ingredient entry additions from the PantryIngredientaddingViewController and renders table rows appropriately formatted to display the user's ingredients. The view controller also updates the entries themselves from the user editing ingredient entries in the PantryIngredEditViewController. This view controller also handles search functionality to filter ingredients based on search input.

//private var developerImages:[UIImage]{
    //
    //        let developers = developerManager.developers
    //        var temp:[UIImage] = []
    //
    //        for(_, developer) in developers.enumerated(){
    //
    //            let image = UIImage(data: developer.image! as Data)
    //            temp.append(image!)
    //        }
    //
    //        return temp
    //    }

import UIKit
import SafariServices

class PantryUpdateIngredViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var pantryTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var searchController: UISearchController!
    
    private var ingredientManager = DataManager.shared
    
    private var deleteIngredientViewModel = PantryDeleteIngredientViewModel()
    
    // Contains all the user's ingredients.
//    var currentIngredients:[String] = []
    
    // Contains all the user's ingredients read in from core database.
    var currentIngredientsFromDatabase:[String]{
        
        let ingredients = ingredientManager.ingredients
        var temp:[String] = []
        
        for(_, ingredient) in ingredients.enumerated(){
            
            let ingredientName = ingredient.name
            let ingredientQty = ingredient.quantity
            let ingredientExp = ingredient.expirationDate
//            let ingredString = "\(ingredientField),\(addingField),\(expiryField)"
            let ingredString = "\(ingredientName!),\(ingredientQty!),\(ingredientExp!)"
            temp.append(ingredString)
        }
        return temp
    }
    
    // Contains all the user's ingredients, used to aid in updating ingredient data
    var currentIngredients:[String] = []
    
    // Contains ingredients contained in the search results.
    var currentDataSourceSearch:[String] = []
    
    // Contains the index of the selected row in the pantry table view containing an ingredient entry the user wishes to edit.
    var currentIngredientsIndexSelection:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI enhancement to reduce unnecessary row lines in pantry table view.
        pantryTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        pantryTableView.dataSource = self
        pantryTableView.delegate = self
        
        currentIngredients = currentIngredientsFromDatabase
        currentDataSourceSearch = currentIngredients
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        // Adding a search bar to the scene.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Ingredients"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        // Get ingredients from data store.
        var ingredientName: String{
            
            var result: String = ""
            let ingredients = ingredientManager.ingredients
            for(_, ingredient) in ingredients.enumerated(){
                
                if let name = ingredient.name{
                    result += name + ","
                }
            }
            return result
        }
        if ingredientName.isEmpty {
            HomeRecipeViewModel().getRandomRecipe()
        }
        else {
            HomeRecipeViewModel().getRecipe(title: ingredientName)
        }
    }
    
    // Filters ingredient pantry table view row results based on user search bar input.
    // Takes into account capital letters, whitespace, and can search based on either ingredient name, quantity, or expiration date.
    func filterCurrentDataSourceSearch(searchTerm: String){
        
        if searchTerm.count > 0{
            
            currentDataSourceSearch = currentIngredients

            let filteredResults = currentDataSourceSearch.filter {$0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
                
            }
            currentDataSourceSearch = filteredResults
            pantryTableView.reloadData()
        }
        else{
            restoreCurrentDataSourceSearch()
        }
    }
    
    // Returns all the user's ingredients to display in the pantry table view after searching.
    func restoreCurrentDataSourceSearch(){
        
        currentDataSourceSearch = currentIngredients
        pantryTableView.reloadData()
    }
    
    // Sends the array containing all the user's ingredients, and the specified index of the array, retrieved from the specified index row in the pantry table view when the user taps on an ingredient cell, to the PantryIngredEditViewController for rendering the text fields with the selected ingredient information to edit.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let selectedCell = pantryTableView.indexPathForSelectedRow else{return}
        
        self.currentIngredientsIndexSelection = selectedCell.row
        
        let destination = segue.destination as? PantryIngredEditViewController
        
//        destination?.currentTotalIngredients = self.currentIngredients
        destination?.currentTotalIngredients = self.currentDataSourceSearch
        
        destination?.currentIngredientsIndexSelection = self.currentIngredientsIndexSelection
        
    }

}

extension PantryUpdateIngredViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentDataSourceSearch.count
    }
    
    // Retrieves the ingredient data from the array containing the current ingredients to be displayed to the user, and parses the ingredient name, quantity, and expiration date into the relevant UILabels.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let inputComponents = currentDataSourceSearch[indexPath.row].components(separatedBy: ",")
        
        let ingredientTitle = inputComponents[0]
        let qtyTitle = inputComponents[1]
        let expTitle = inputComponents[2]
        
        let cell = pantryTableView.dequeueReusableCell(withIdentifier: "IngredientCell") as! IngredientCell
        cell.ingredientTitle?.text = ingredientTitle
        
        cell.qtyTitle?.text = qtyTitle
        cell.expTitle?.text = expTitle
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Deletes a table row.
    // The respective ingredient entry in the specified index of the ingredient core database is also deleted
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            deleteIngredientViewModel.deleteIngredient(indexPath.row)
            
            currentIngredients.remove(at: indexPath.row)
            
//            PantryIngredientaddingViewController.ingredInput.remove(at: indexPath.row) 
            
            currentDataSourceSearch = currentIngredients
            
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
