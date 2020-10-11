//
//  StudentDeveloperViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This struct holds all the students in the development team, and also allows for
// retrieval of a specific developer from the developers database, for detail view rendering.

import Foundation

import UIKit

struct StudentDeveloperViewModel{
    
    private var studentDeveloper = StudentDeveloper()
    
    private (set) var developers = DataManager.shared.developers
    
    var count:Int{
        
        return developers.count
    }
    
    init() {
        loadData()
        developers = DataManager.shared.developers
    }
    
    // Adds all the students in the development team into the developers array.
    private mutating func loadData(){
        
        if(count == 0){
            studentDeveloper.addAllDevelopers()
        }
    }
    
    // Returns a specified developer.
    func getDeveloper(byIndex index:Int) -> (name:String,
        description:String, image:UIImage?){
            
            let name = developers[index].name!
            let description = developers[index].developerBio!
            let image = UIImage(data: developers[index].image! as Data)
            
            return (name, description, image)
    }
}
