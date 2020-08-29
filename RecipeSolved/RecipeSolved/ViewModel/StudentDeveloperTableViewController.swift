//
//  StudentDeveloperTableViewController.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class StudentDeveloperTableViewController: UITableViewController {

    private let developerViewModel = StudentDeveloperViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return developerViewModel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentDeveloperCell", for: indexPath)

        let imageView = cell.viewWithTag(240) as? UIImageView
        let developerName = cell.viewWithTag(241) as?
            UILabel
//        let developerDesc = cell.viewWithTag(242) as?
//            UILabel

        if let imageView = imageView, let developerName = developerName{
            
            let currentDeveloper = developerViewModel.getDeveloper(byIndex: indexPath.row)
            
            imageView.image = currentDeveloper.image
            developerName.text = currentDeveloper.name
//            developerDesc.text = currentDeveloper.description
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedRow = self.tableView.indexPathForSelectedRow else{
            return
        }
        
        let destination = segue.destination as? StudentDetailViewController
        
        let selectedStudent = developerViewModel.getDeveloper(byIndex: selectedRow.row)
        
        destination?.selectedStudent = selectedStudent
    }
    

}
