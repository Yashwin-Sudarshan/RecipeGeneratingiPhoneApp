//
//  PantryUpdateIngredViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 19/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit
import SafariServices

class PantryUpdateIngredViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var pantryTableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    
    var searchController: UISearchController!
    
    var currentIngredients:[String] = []
    var currentDataSourceSearch:[String] = []
    
    var currentIngredientsIndexSelection:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pantryTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        pantryTableView.dataSource = self
        pantryTableView.delegate = self
        
        currentDataSourceSearch = currentIngredients
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
    }
    
    // Might be redundant
    func insertNewIngredient(){

        let indexPath = IndexPath(row: currentIngredients.count - 1, section: 0)

        pantryTableView.beginUpdates()
        pantryTableView.insertRows(at: [indexPath], with: .automatic)
        pantryTableView.endUpdates()
        view.endEditing(true)
    }
    
    
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
    
    func restoreCurrentDataSourceSearch(){
        
        currentDataSourceSearch = currentIngredients
        pantryTableView.reloadData()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//        let vcTransfer = segue.destination as! PantryUpdateIngredViewController
//        vcTransfer.currentIngredients = PantryIngredientaddingViewController.ingredInput
        
//        guard let selectedRow = self.tableView.indexPathForSelectedRow else{return}
//
//        let destination = segue.destination as? RecipeViewController
//
//        let selectedRecipe = viewModel.getRecipe(byIndex: selectedRow.row)
//
//        destination?.selectedRecipe = selectedRecipe
        
        guard let selectedCell = pantryTableView.indexPathForSelectedRow else{return}
        
        self.currentIngredientsIndexSelection = selectedCell.row
        
        let destination = segue.destination as? PantryIngredEditViewController
        
//        let selectedIngredient = self.currentIngredients[selectedCell.row]
        
//        destination?.selectedIngredient = [selectedIngredient]
        
        destination?.currentTotalIngredients = self.currentIngredients
        
        destination?.currentIngredientsIndexSelection = self.currentIngredientsIndexSelection
        
    }
    
    
    
    
}

extension PantryUpdateIngredViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentDataSourceSearch.count
    }
    
    
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            currentIngredients.remove(at: indexPath.row)
            
            PantryIngredientaddingViewController.ingredInput.remove(at: indexPath.row) 
            
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
