//
//  PantryIngredEditViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 27/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import UIKit

class PantryIngredEditViewController: UIViewController{
    
    
//    var selectedIngredient:(ingredient:String, adding:String, expiry:String)?
    
//    let inputComponents = currentDataSourceSearch[indexPath.row].components(separatedBy: ",")
    
    var selectedIngredient:[String] = []
    var currentTotalIngredients:[String] = []
    var currentIngredientsIndexSelection:Int = 0
    
    @IBOutlet weak var editIngredientTextField: UITextField!
    @IBOutlet weak var editAddingTextField: UITextField!
    @IBOutlet weak var editExpiryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let selectedIngredient = selectedIngredient{
//
//            editIngredientTextField.text = selectedIngredient.ingredient
//            editAddingTextField.text = selectedIngredient.adding
//            editExpiryTextField.text = selectedIngredient.expiry
//        }
      
//        let inputComponents = selectedIngredient[0].components(separatedBy: ",")
        
        let inputComponents = currentTotalIngredients[currentIngredientsIndexSelection].components(separatedBy: ",")
        
        editIngredientTextField.text = inputComponents[0]
                    editAddingTextField.text = inputComponents[1]
                    editExpiryTextField.text = inputComponents[2]
        
    }

    @IBAction func confirmEditTap(_ sender: Any) {
        
        let ingredString = "\(editIngredientTextField.text!),\(editAddingTextField.text!),\(editExpiryTextField.text!)"
        
//        self.selectedIngredient[0] = ingredString
        self.currentTotalIngredients[self.currentIngredientsIndexSelection] = ingredString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vcTransfer = segue.destination as! PantryUpdateIngredViewController
        
        vcTransfer.currentIngredients =  self.currentTotalIngredients
        
    }
    
}
