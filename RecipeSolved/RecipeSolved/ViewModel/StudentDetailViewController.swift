//
//  StudentDetailViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This view controller renders the student image, name, and bio in the student detail views.

import UIKit

class StudentDetailViewController: UIViewController {

    
    @IBOutlet weak var studentImage: UIImageView!
    
    @IBOutlet weak var studentName: UILabel!
    
    @IBOutlet weak var studentDetail: UITextView!
    
    var selectedStudent:(name:String, description:String, image:UIImage?)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedStudent = selectedStudent{
            
            studentImage.image = selectedStudent.image
            studentName.text = selectedStudent.name
            studentDetail.text = selectedStudent.description
            studentDetail.isSelectable = false
        }
    }

}
