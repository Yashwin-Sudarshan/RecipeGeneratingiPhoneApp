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
    
    private var studentDeveloper = StudentDeveloper()
    
    private (set) var developers = DataManager.shared.developers
    
    // Contains all the students in the development team.
//    private (set) var developers:[StudentDeveloper] = []
    // Uses database --> probs replaces above code
//    private var developerManager = DataManager.shared
//    private var addingDeveloperViewModel = StudentDeveloperAddDeveloperViewModel()
    
//    private var developerImages:[UIImage]{
//
//        let developers = developerManager.developers
//        var temp:[UIImage] = []
//
//        for(_, developer) in developers.enumerated(){
//
//            let image = UIImage(data: developer.image! as Data)
//            temp.append(image!)
//        }
//
//        return temp
//    }
    
    var count:Int{
        
        return developers.count
    }
    
    init() {
        loadData()
        developers = DataManager.shared.developers
        // Above line fixes bug when loading developers for the first time
    }
    
    // Adds all the students in the development team into the developers array.
    private mutating func loadData(){
        
        if(count == 0){
            studentDeveloper.addAllDevelopers()
        }
        
//        let developers = developerManager.developers
//        if(developers.count == 0){
//            addAllDevelopers()
//        }
//        developers.append(StudentDeveloper.RubyRio)
//        developers.append(StudentDeveloper.AlexanderLoMoro)
//        developers.append(StudentDeveloper.AlexandarKotevski)
//        developers.append(StudentDeveloper.YashwinSudarshan)
    }
    
    // Returns a specified developer.
    func getDeveloper(byIndex index:Int) -> (name:String,
        description:String, image:UIImage?){
            
//            let name = developers[index].rawValue
//            let description = developers[index].description
//            let image = UIImage(named: developers[index].imageName)
            
            let name = developers[index].name!
            let description = developers[index].developerBio!
            let image = UIImage(data: developers[index].image! as Data)
            
            return (name, description, image)
    }
}
