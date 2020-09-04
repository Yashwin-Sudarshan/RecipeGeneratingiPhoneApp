//
//  StudentDeveloperTableViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This view controller handles student table view master functionality, when the user taps on a cell
// containing a developer. This view controller will send the details of that particular student
// to the StudentDetailViewController, for rendering of further details for viewing.

import UIKit

class StudentDeveloperTableViewController: UITableViewController {

    private let developerViewModel = StudentDeveloperViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return developerViewModel.count
    }

    // Retrieves the developers from the StudentDeveloperViewModel and renders them as table row cells
    // rendering the student image and student name in the student profile master view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentDeveloperCell", for: indexPath)

        let imageView = cell.viewWithTag(240) as? UIImageView
        let developerName = cell.viewWithTag(241) as?
            UILabel

        if let imageView = imageView, let developerName = developerName{
            
            let currentDeveloper = developerViewModel.getDeveloper(byIndex: indexPath.row)
            
            imageView.image = currentDeveloper.image
            developerName.text = currentDeveloper.name
        }
        
        return cell
    }

    // Transfers the details of the selected student in the student profile master view
    // to the student profile detail view represented by StudentDetailViewController,
    // for rendering of their full details.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedRow = self.tableView.indexPathForSelectedRow else{
            return
        }
        
        let destination = segue.destination as? StudentDetailViewController
        
        let selectedStudent = developerViewModel.getDeveloper(byIndex: selectedRow.row)
        
        destination?.selectedStudent = selectedStudent
    }
    

}
