//
//  StudentDeveloperAddDeveloperViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 26/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This struct performs addition of a developer to the devloper core database

import Foundation
import UIKit

struct StudentDeveloperAddDeveloperViewModel {
    
    private var developerManager = DataManager.shared
    
    // Adds developers to the database
    mutating func addDeveloper(_ name: String, _ image: String, _ developerBio : String){
        
        guard let developerImage = UIImage(named: image) else {return}
        
        developerManager.addDeveloper(name, developerImage, developerBio)
    }
}
