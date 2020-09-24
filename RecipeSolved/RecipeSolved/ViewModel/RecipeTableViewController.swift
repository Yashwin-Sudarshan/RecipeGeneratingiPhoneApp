//
//  TableViewController.swift
//  RecipeSolved
//
//  Created by Alexandar Kotevski on 21/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class RecipeTableViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, Refresh {
    
    var viewModel = RecipeViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        viewModel.getRecipe(title: searchBar.text!)
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        viewModel.delegate = self
        searchBar.placeholder = "Search Recipes"
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }

    // Find the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    // Draw the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let imageView = cell.viewWithTag(1000) as! UIImageView
        let recipeTitle = cell.viewWithTag(1001) as! UILabel
        let recipeItems = cell.viewWithTag(1003) as! UILabel
        let recipeServings = cell.viewWithTag(1004) as! UILabel
        
        imageView.image = viewModel.getImageFor(index: indexPath.row)
        recipeTitle.text = viewModel.getTitleFor(index: indexPath.row)
        recipeItems.text = viewModel.getItemsFor(index: indexPath.row)
        recipeServings.text = viewModel.getServingsFor(index: indexPath.row)
        
        return cell
    }

    // When you click on a table cell, go to the RecipeViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedRow = self.tableView.indexPathForSelectedRow else {return}
        let destination = segue.destination as? RecipeViewController
        let selectedRecipe = viewModel.getAllFor(index: selectedRow.row)
        destination?.selectedRecipe = selectedRecipe
    }

}
