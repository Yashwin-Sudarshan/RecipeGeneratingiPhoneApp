//
//  PantryIngredientAddingViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 19/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This view controller retrieves user input for adding ingredients and thier names, quantities
// and expiration dates. Then, it sends the information to the PantryUpdateIngredViewController
// for displaying the ingredients and their details in the user's pantry. This view controller also
// handles data validation to ensure only entries in the correct format get transferred.

import UIKit

class PantryIngredientaddingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var currentField: UITextField!
    @IBOutlet weak var addingField: UITextField!
    @IBOutlet weak var expiryField: UITextField!
    @IBOutlet weak var totalField: UITextField!
    
    @IBOutlet weak var confirmEntryButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Holds all of user's ingredient entries
    static var ingredInput:[String] = []
    
    var validator = PantryValidator()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        ingredientField.delegate = self
        addingField.delegate = self
        expiryField.delegate = self
        
        // Listens for events from keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // Checks validity of user inputs in each text field in real time
        [ingredientField, addingField, expiryField].forEach({$0?.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)})
        
    }
    
    // Sets the 'Confirm Entry' button to disabled and increases its transparency.
    override func viewWillAppear(_ animated: Bool) {
        
        confirmEntryButton.isEnabled = false
        confirmEntryButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 0.1)
        confirmEntryButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.1), for: .normal)
    }
    
    // Un-registering keyboard event listeners
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    // Adds user ingredient, quantity, and date inputs into array for transportation into
    // PantryUpdateIngredViewController
    @IBAction func confirmEntryTap(_ sender: Any) {
        
        if(validateInput() == true){
            
            let ingredString = "\(ingredientField.text!),\(addingField.text!),\(expiryField.text!)"
           
            PantryIngredientaddingViewController.ingredInput.append(ingredString)
            
        }
    }
    
    // Validates ingredient, quantity, and date input formats.
    private func validateInput() -> Bool{
        
        var isValid = false
        
        guard let ingredient = ingredientField.text, let qty = addingField.text, let exp = expiryField.text else{
            return false
        }
        
        isValid = self.validator.validatePantryInputs(ingredient: ingredient, qty: qty, exp: exp)
        
        return isValid
    }
    
    // Checks if all text field input is valid in real time, and updates the opacity of the
    // 'Confirm Entry' button accordingly, and its enabled status.
    @objc func editingChanged(_ textField: UITextField){
        
        if(validateInput() == true){
            
            confirmEntryButton.isEnabled = true
            confirmEntryButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 1)
            confirmEntryButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1), for: .normal)
            
        }else{
            
            confirmEntryButton.isEnabled = false

            confirmEntryButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 0.1)
            confirmEntryButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.1), for: .normal)

        }
    }
    
    // Allows user to hide keyboard by tapping 'Return'.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        ingredientField.resignFirstResponder()
        addingField.resignFirstResponder()
        expiryField.resignFirstResponder()

    }
    
    // Transfers contents of array containing ingredients entered by user, into
    // another array in the PantryUpdateIngredViewController, for table view rendering.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let vcTransfer = segue.destination as! PantryUpdateIngredViewController
         vcTransfer.currentIngredients = PantryIngredientaddingViewController.ingredInput
        
    }
    
    // Allows user to use the camera (for scanning barcode functionality - not implemented yet
    // as it requires use of the API for data retrieval).
    // Currently, this method allows the user to use the camera only.
    @IBAction func takePhoto(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
}

extension PantryIngredientaddingViewController: UITextFieldDelegate{
    
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
