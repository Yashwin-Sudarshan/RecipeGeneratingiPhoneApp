//
//  PantryIngredEditViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 27/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This view controller handles editing ingredient entries by the user. The ingredient name,
// quantity, and expiration date can be changed, and the view controller will update the array
// containing ingredients in the PantryUpdateIngredViewController for updated display of ingredient
// information. This view controller also handles input format validation, to ensure only entries
// with the correct ingredient name, quantity, and expiration date formats are accepted.

import Foundation
import UIKit

class PantryIngredEditViewController: UIViewController{
    
    var currentTotalIngredients:[String] = []
    var currentIngredientsIndexSelection:Int = 0
    
    @IBOutlet weak var editIngredientTextField: UITextField!
    @IBOutlet weak var editAddingTextField: UITextField!
    @IBOutlet weak var editExpiryTextField: UITextField!
    
    private var datePickerComponent: UIDatePicker?
    
    @IBOutlet weak var confirmEditButton: UIButton!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var validator = PantryValidator()
    
    private var updateIngredientViewModel = PantryUpdateIngredientViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editIngredientTextField.delegate = self
        editAddingTextField.delegate = self
        editExpiryTextField.delegate = self
        
        let inputComponents = currentTotalIngredients[currentIngredientsIndexSelection].components(separatedBy: ",")
        
        // Parses ingredient data from
        editIngredientTextField.text = inputComponents[0]
                    editAddingTextField.text = inputComponents[1]
                    editExpiryTextField.text = inputComponents[2]
        
        // Adds date picker component into expiry field and allows the user to exit the
        // date picker by tapping the scene
        datePickerComponent = UIDatePicker()
        datePickerComponent?.datePickerMode = .date
        
        datePickerComponent?.addTarget(self, action: #selector(self.dateAltered(datePickerComponent:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTouched(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        editExpiryTextField.inputView = datePickerComponent
        
        // Listens for events from keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
     
        // Checks validity of user inputs in each text field in real time
        [editIngredientTextField, editAddingTextField, editExpiryTextField].forEach({$0?.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)})
        
    }
    
    // Sets the 'Confirm Edit' button to enabled
    override func viewWillAppear(_ animated: Bool) {
        
        confirmEditButton.isEnabled = true
    }
    
    // Un-registering keyboard event listeners
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    // Updates the index entry of the array of all the user's ingredients, to the specified user edit.
    @IBAction func confirmEditTap(_ sender: Any) {
        
        if(validateInput() == true){
            
            guard let editIngredientField = editIngredientTextField.text, let editAddingField = editAddingTextField.text, let editExpiryField = editExpiryTextField.text else {return} // extra validation --> probs redundant --> 'guard' probs not needed
            
            updateIngredientViewModel.updateIngredient(editIngredientField, editAddingField, editExpiryField, self.currentIngredientsIndexSelection)
            
//            let ingredString = "\(editIngredientTextField.text!),\(editAddingTextField.text!),\(editExpiryTextField.text!)"
            
            let ingredString = "\(editIngredientField),\(editAddingField),\(editExpiryField)"
            
            self.currentTotalIngredients[self.currentIngredientsIndexSelection] = ingredString
        }
    }
    
    // Validates ingredient, quantity, and date input formats.
    private func validateInput() -> Bool{
        
        var isValid = false
        
        guard let ingredient = editIngredientTextField.text, let qty = editAddingTextField.text, let exp = editExpiryTextField.text else{
            return false
        }
        
        if(exp.isEmpty){
            return false
        }
//        isValid = self.validator.validatePantryInputs(ingredient: ingredient, qty: qty, exp: exp)
        isValid = self.validator.validatePantryInputs(ingredient: ingredient, qty: qty)
        
        return isValid
    }
    
    // Checks if all text field input is valid in real time, and updates the opacity of the
    // 'Confirm Edit' button accordingly, and its enabled status.
    @objc func editingChanged(_ textField: UITextField){
        
        if(validateInput() == true){
            
            confirmEditButton.isEnabled = true
            confirmEditButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 1)
            confirmEditButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1), for: .normal)
            
        }else{
            
            confirmEditButton.isEnabled = false
            confirmEditButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 0.1)
            confirmEditButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.1), for: .normal)
        }
    }
    
    // Formats date selection and returns the date as a text entry into the expiry text field
    @objc func dateAltered(datePickerComponent: UIDatePicker){
        
        let dateInputFormatter = DateFormatter()
        dateInputFormatter.dateFormat = "dd/MM/yy"
        editExpiryTextField.text = dateInputFormatter.string(from: datePickerComponent.date)
        editingChanged(editExpiryTextField)
    }
    
    // Allows user to hide date picker by tapping the scene
    @objc func viewTouched(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    // Allows user to hide keyboard by tapping 'Return'.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        editIngredientTextField.resignFirstResponder()
        editAddingTextField.resignFirstResponder()
        editExpiryTextField.resignFirstResponder()
    }
    
    // Transfers contents of array containing all ingredients (including the updated ingredient entry)
    // entered by user, into another array in the PantryUpdateIngredViewController, for table view
    // rendering.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vcTransfer = segue.destination as! PantryUpdateIngredViewController
        
        vcTransfer.currentIngredients =  self.currentTotalIngredients
        
    }
}

extension PantryIngredEditViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Makes the keyboard rise a certain level depending on the text field tapped.
    // Automatically scrolls the view when tapping into another text field, so that
    // the keyboard does not obscure the fields for input.
    @objc func keyboardWillChange(notification: Notification){
    
        let userInput = notification.userInfo!
        
        let keyboardContainerEndFrame = (userInput[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardContainerViewEndFrame = view.convert(keyboardContainerEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide{
            
            scrollView.contentInset = UIEdgeInsets.zero
        }else{
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardContainerViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}
