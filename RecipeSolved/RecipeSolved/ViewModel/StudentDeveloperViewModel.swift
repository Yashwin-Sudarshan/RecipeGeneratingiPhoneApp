//
//  StudentDeveloperViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This struct holds all the students in the development team, and also allows for
// retrieval of a specific developer from the developers array, for detail view rendering.

import Foundation

import UIKit

struct StudentDeveloperViewModel{
    
    // Contains all the students in the development team.
    private (set) var developers:[StudentDeveloper] = []
    
    var count:Int{
        
        return developers.count
    }
    
    init() {
        loadData()
    }
    
    // Adds all the students in the development team into the developers array.
    private mutating func loadData(){
        
        developers.append(StudentDeveloper.RubyRio)
        developers.append(StudentDeveloper.AlexanderLoMoro)
        developers.append(StudentDeveloper.AlexandarKotevski)
        developers.append(StudentDeveloper.YashwinSudarshan)
    }
    
    // Returns a specified developer.
    func getDeveloper(byIndex index:Int) -> (name:String,
        description:String, image:UIImage?){
            
            let name = developers[index].rawValue
            let description = developers[index].description
            let image = UIImage(named: developers[index].imageName)
            
            return (name, description, image)
    }
}
