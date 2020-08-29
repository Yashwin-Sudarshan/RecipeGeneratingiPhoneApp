//
//  StudentDeveloperViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation

import UIKit

struct StudentDeveloperViewModel{
    
    private (set) var developers:[StudentDeveloper] = []
    
    var count:Int{
        
        return developers.count
    }
    
    init() {
        loadData()
    }
    
    private mutating func loadData(){
        
        developers.append(StudentDeveloper.RubyRio)
        developers.append(StudentDeveloper.AlexanderLoMoro)
        developers.append(StudentDeveloper.AlexandarKotevski)
        developers.append(StudentDeveloper.YashwinSudarshan)
    }
    
    func getDeveloper(byIndex index:Int) -> (name:String,
        description:String, image:UIImage?){
            
            let name = developers[index].rawValue
            let description = developers[index].description
            let image = UIImage(named: developers[index].imageName)
            
            return (name, description, image)
    }
}
