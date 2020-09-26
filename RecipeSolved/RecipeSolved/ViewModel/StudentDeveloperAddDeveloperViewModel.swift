//
//  StudentDeveloperAddDeveloperViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 26/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import UIKit

struct StudentDeveloperAddDeveloperViewModel {
    
    private var developerManager = DataManager.shared
    
    // Might be redundant --> transform for display to view?
    var developerName: String{
        
        var result: String = ""
        let developers = developerManager.developers
        for(_, developer) in developers.enumerated(){
            
            if let name = developer.name{
                result += name + "\n"
            }
        }
        return result
    }
    
    // Adds developers to the database
    mutating func addDeveloper(_ name: String, _ image: String, _ developerBio : String){
        
        guard let developerImage = UIImage(named: image) else {return}
        
        developerManager.addDeveloper(name, developerImage, developerBio)
    }
}
