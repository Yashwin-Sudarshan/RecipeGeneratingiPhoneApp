//
//  PantryCameraViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 18/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit


// Might be a redundant class
class PantryCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{ 
    
//    @IBOutlet var ScImageView: UIImageView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    // Opens camera; Scanning functionality not yet implemented 
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
