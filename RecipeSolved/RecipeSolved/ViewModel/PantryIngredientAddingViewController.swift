//
//  PantryIngredientAddingViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 19/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class PantryIngredientaddingViewController: UIViewController{
    
    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var currentField: UITextField!
    @IBOutlet weak var addingField: UITextField!
    @IBOutlet weak var expiryField: UITextField!
    @IBOutlet weak var totalField: UITextField!
    
//    let model = YourModelObject.sharedInstance
//    var plistNumber = model.currentTableNumber
    
    
    
    static var ingredInput:[String] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        ingredientField.delegate = self
//        currentField.delegate = self
        addingField.delegate = self
        expiryField.delegate = self
//        totalField.delegate = self
        
    }
    
    @IBAction func confirmEntryTap(_ sender: Any) {
    
//        let ingredString = "\(ingredientField.text!),\(currentField.text!),\(addingField.text!),\(expiryField.text!),\(totalField.text!)"
        
        let ingredString = "\(ingredientField.text!),\(addingField.text!),\(expiryField.text!)"
        
        PantryIngredientaddingViewController.ingredInput.append(ingredString)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        ingredientField.resignFirstResponder()
        currentField.resignFirstResponder()
        addingField.resignFirstResponder()
        expiryField.resignFirstResponder()
        totalField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let vcTransfer = segue.destination as! PantryUpdateIngredViewController
         vcTransfer.currentIngredients = PantryIngredientaddingViewController.ingredInput
        
//        vcTransfer.currentIngredients.append(PantryIngredientaddingViewController.ingredInput[0])
//        PantryIngredientaddingViewController.ingredInput.removeFirst()
        
//        vcTransfer.insertNewIngredient()
        // append then delete
    }
    
}

extension PantryIngredientaddingViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
