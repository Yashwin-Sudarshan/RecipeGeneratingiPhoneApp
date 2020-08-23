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
    
    var currentIngredients:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pantryTableView.tableFooterView = UIView(frame: CGRect.zero)
        pantryTableView.dataSource = self
        pantryTableView.delegate = self
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    // Might be redundant
    func insertNewIngredient(){

        let indexPath = IndexPath(row: currentIngredients.count - 1, section: 0)

        pantryTableView.beginUpdates()
        pantryTableView.insertRows(at: [indexPath], with: .automatic)
        pantryTableView.endUpdates()
        view.endEditing(true)
    }
    
    
}

extension PantryUpdateIngredViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentIngredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let inputComponents = currentIngredients[indexPath.row].components(separatedBy: ",")
        
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
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
