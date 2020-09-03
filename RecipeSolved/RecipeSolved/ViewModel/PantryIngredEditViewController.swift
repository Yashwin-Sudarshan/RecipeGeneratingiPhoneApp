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
    
    @IBOutlet weak var confirmEditButton: UIButton!
    
    var validator = PantryValidator()
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
     
        [editIngredientTextField, editAddingTextField, editExpiryTextField].forEach({$0?.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)})
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        confirmEditButton.isEnabled = false
        confirmEditButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 1)
        confirmEditButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1), for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    @IBAction func confirmEditTap(_ sender: Any) {
        
        if(validateInput() == true){
            
            let ingredString = "\(editIngredientTextField.text!),\(editAddingTextField.text!),\(editExpiryTextField.text!)"
            
            //        self.selectedIngredient[0] = ingredString
            self.currentTotalIngredients[self.currentIngredientsIndexSelection] = ingredString
        }
        
//        let ingredString = "\(editIngredientTextField.text!),\(editAddingTextField.text!),\(editExpiryTextField.text!)"
//
////        self.selectedIngredient[0] = ingredString
//        self.currentTotalIngredients[self.currentIngredientsIndexSelection] = ingredString
    }
    
    private func validateInput() -> Bool{
        
        var isValid = false
        
        guard let ingredient = editIngredientTextField.text, let qty = editAddingTextField.text, let exp = editExpiryTextField.text else{
            return false
        }
        
        isValid = self.validator.validatePantryInputs(ingredient: ingredient, qty: qty, exp: exp)
        
//        let isValidateIngredient = self.validation.validateIngredient(ingredient: ingredient)
//        if(isValidateIngredient == false){
//
//            //            print("Invalid ingredient input")
//            isValid = false
//        }
//
//        let isValidateQty = self.validation.validateQty(qty: qty)
//        if(isValidateQty == false){
//
//            //            print("Invalid qty input")
//            isValid = false
//        }
//
//        let isValidateExp = self.validation.validateExp(exp: exp)
//        if(isValidateExp == false){
//
//            //            print("Invalid date input")
//            isValid = false
//        }
//
//        if(isValidateIngredient == true && isValidateQty == true && isValidateExp == true){
//
//            //            print("Invalid ingredient, qty, and/or date input")
//            isValid = true
//        }
        
        return isValid
    }
    
    @objc func editingChanged(_ textField: UITextField){
        
        if(validateInput() == true){
            
            confirmEditButton.isEnabled = true
            //            confirmEntryButton.isOpaque = false
            confirmEditButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 1)
            //            confirmEntryButton.titleLabel?.alpha = 1
            confirmEditButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1), for: .normal)
            
        }else{
            
            confirmEditButton.isEnabled = false
            //            confirmEntryButton.isOpaque = true
            //            confirmEntryButton.backgroundColor =
            confirmEditButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 0.1)
            //            confirmEntryButton.titleLabel?.alpha = 0.1
            confirmEditButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.1), for: .normal)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        editIngredientTextField.resignFirstResponder()
        editAddingTextField.resignFirstResponder()
        editExpiryTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vcTransfer = segue.destination as! PantryUpdateIngredViewController
        
        vcTransfer.currentIngredients =  self.currentTotalIngredients
        
    }
    
    func shouldPerformSegueWithIdentifier(identifier:String, sender:AnyObject?) -> Bool {
        
        if identifier == "EditIngredSegue" && validateInput() == true{
            
            return true
        }
        
        return false
    }
    
}

extension PantryIngredEditViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillChange(notification: Notification){
        
        guard let keyboardRectangle = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            
            return
        }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame{
            
            view.frame.origin.y = -keyboardRectangle.height
        }else{
            
            view.frame.origin.y = 0
        }
    }
}
