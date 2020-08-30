//
//  PantryIngredientAddingViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 19/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class PantryIngredientaddingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var currentField: UITextField!
    @IBOutlet weak var addingField: UITextField!
    @IBOutlet weak var expiryField: UITextField!
    @IBOutlet weak var totalField: UITextField!
    
    @IBOutlet weak var confirmEntryButton: UIButton!
    
//    @IBOutlet weak var textView: UITextView!
    
    static var ingredInput:[String] = []
    
    var validation = Validation()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        ingredientField.delegate = self
//        currentField.delegate = self
        addingField.delegate = self
        expiryField.delegate = self
//        totalField.delegate = self
        
//       textView.text = "Fill in the fields below to add your available ingredient to your pantry"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        [ingredientField, addingField, expiryField].forEach({$0?.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)})
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        confirmEntryButton.isEnabled = false
//        confirmEntryButton.isOpaque = true
        confirmEntryButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 0.1)
//        confirmEntryButton.titleLabel?.alpha = 0.1
        confirmEntryButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.1), for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @IBAction func confirmEntryTap(_ sender: Any) {
    
        
//        guard let ingredient = ingredientField.text, let qty = addingField.text, let exp = expiryField.text else{
//            return
//        }
//
//        let isValidateIngredient = self.validation.validateIngredient(ingredient: ingredient)
//        if(isValidateIngredient == false){
//
//            print("Invalid ingredient input")
//            return
//        }
//
//        let isValidateQty = self.validation.validateQty(qty: qty)
//        if(isValidateQty == false){
//
//            print("Invalid qty input")
//            return
//        }
//
//        let isValidateExp = self.validation.validateExp(exp: exp)
//        if(isValidateExp == false){
//
//            print("Invalid date input")
//            return
//        }
        
//        if(isValidateIngredient == true && isValidateQty == true && isValidateExp == true){
        
        if(validateInput() == true){
            
            let ingredString = "\(ingredientField.text!),\(addingField.text!),\(expiryField.text!)"
           
            PantryIngredientaddingViewController.ingredInput.append(ingredString)
            
        }
        
//            let ingredString = "\(ingredientField.text!),\(addingField.text!),\(expiryField.text!)"
//
//            PantryIngredientaddingViewController.ingredInput.append(ingredString)
//        }
        
//        let ingredString = "\(ingredientField.text!),\(addingField.text!),\(expiryField.text!)"
//
//        PantryIngredientaddingViewController.ingredInput.append(ingredString)
        
    }
    
    
    private func validateInput() -> Bool{
        
        var isValid = false
        
        guard let ingredient = ingredientField.text, let qty = addingField.text, let exp = expiryField.text else{
            return false
        }
        
        let isValidateIngredient = self.validation.validateIngredient(ingredient: ingredient)
        if(isValidateIngredient == false){
            
//            print("Invalid ingredient input")
            isValid = false
        }
        
        let isValidateQty = self.validation.validateQty(qty: qty)
        if(isValidateQty == false){
            
//            print("Invalid qty input")
            isValid = false
        }
        
        let isValidateExp = self.validation.validateExp(exp: exp)
        if(isValidateExp == false){
            
//            print("Invalid date input")
            isValid = false
        }
        
        if(isValidateIngredient == true && isValidateQty == true && isValidateExp == true){
            
//            print("Invalid ingredient, qty, and/or date input")
            isValid = true
        }
        
        return isValid
    }
    
    @objc func editingChanged(_ textField: UITextField){
        
        if(validateInput() == true){
            
            confirmEntryButton.isEnabled = true
//            confirmEntryButton.isOpaque = false
            confirmEntryButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 1)
//            confirmEntryButton.titleLabel?.alpha = 1
            confirmEntryButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1), for: .normal)
            
        }else{
            
            confirmEntryButton.isEnabled = false
//            confirmEntryButton.isOpaque = true
//            confirmEntryButton.backgroundColor =
            confirmEntryButton.backgroundColor = UIColor(red: 0.603, green: 0.603, blue: 0.603, alpha: 0.1)
//            confirmEntryButton.titleLabel?.alpha = 0.1
            confirmEntryButton.setTitleColor(UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.1), for: .normal)

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        ingredientField.resignFirstResponder()
//        currentField.resignFirstResponder()
        addingField.resignFirstResponder()
        expiryField.resignFirstResponder()
//        totalField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let vcTransfer = segue.destination as! PantryUpdateIngredViewController
         vcTransfer.currentIngredients = PantryIngredientaddingViewController.ingredInput
        
    }
    
    
    func shouldPerformSegueWithIdentifier(identifier:String, sender:AnyObject?) -> Bool {

        if identifier == "AddingIngredSegue" && validateInput() == true{

            return true
        }

        return false
    }
    
    
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
    
    @objc func keyboardWillChange(notification: Notification){
        
        guard let keyboardRectangle = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            
            return
        }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            
            view.frame.origin.y = -keyboardRectangle.height
        }else{
            
            view.frame.origin.y = 0
        }
    }
}
