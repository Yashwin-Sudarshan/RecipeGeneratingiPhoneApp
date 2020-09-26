//
//  DisplayStudentDeveloperViewModel.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 26/9/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation
import UIKit

// Might be a redundant class --> To be removed at a later stage
struct DisplayStudentDeveloperViewModel{
    
    private var developerManager = DataManager.shared
    
    // Might be redundant --> Transforms developer images from database
    private var developerImages:[UIImage]{
        
        let developers = developerManager.developers
        var temp:[UIImage] = []
        
        for(_, developer) in developers.enumerated(){
            
            let image = UIImage(data: developer.image! as Data)
            temp.append(image!)
        }
        
        return temp
    }
    
    // Below code might be redundant
    private var index:Int = 1
    
    mutating func getNextImage() -> UIImage?{
        
        var image = UIImage(named: "Magician")
        if developerImages.count != 0{
            
            if developerImages.count == 1 || index == developerImages.count - 1 {
                index = 0
            }else{
                index += 1
            }
            image = developerImages[index]
        }
        return image
    }
}
