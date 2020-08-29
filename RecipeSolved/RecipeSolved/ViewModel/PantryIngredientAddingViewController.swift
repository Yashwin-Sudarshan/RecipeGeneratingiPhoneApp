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
    
//    @IBOutlet weak var textView: UITextView!
    
    static var ingredInput:[String] = []
    
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
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @IBAction func confirmEntryTap(_ sender: Any) {
    
        let ingredString = "\(ingredientField.text!),\(addingField.text!),\(expiryField.text!)"
        
        PantryIngredientaddingViewController.ingredInput.append(ingredString)
        
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
