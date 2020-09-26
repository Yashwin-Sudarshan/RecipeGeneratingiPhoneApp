//
//  StudentDeveloper.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This enum represents the entire development team and thier details.


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


import Foundation
import UIKit //Might be redundant here

struct StudentDeveloper{
    
    private var developerManager = DataManager.shared
    private var addingDeveloperViewModel = StudentDeveloperAddDeveloperViewModel()
    
    init(){
        
//        let developers = developerManager.developers
//        if(developers.count == 0){
//            addAllDevelopers()
//        }
    }
    
    mutating func addAllDevelopers(){
        
        addingDeveloperViewModel.addDeveloper("Ruby Rio", "rubyrio", "Ruby Rio is a second-year Bachelor of Software Engineering student at RMIT University. Ruby has a keen interest in Project Management in relation of Information Technology Projects, and to see how this area can develop. Ruby's other interests include Business Systems, Law, Piano and Fitness.")
        addingDeveloperViewModel.addDeveloper("Alexander LoMoro", "alexanderlomoro", "Alexander LoMoro is a second-year Bachelor of Technology (Computing Studies) student at RMIT University. Alexander has a keen interest in UX Design, escpecially in mobile environments. Other interests of Alexander include cars, technology & sports.")
        addingDeveloperViewModel.addDeveloper("Alexandar Kotevski", "alexandarkotevski", "Alexandar Kotevski is a final-year Bachelor of Information Technology student at RMIT University. Alexandar is interested in mobile app and web development. Alexandar's other interests include Apple, weather and aviation.")
        addingDeveloperViewModel.addDeveloper("Yashwin Sudarshan", "yashwinsudarshan", "Yashwin Sudarshan is a second-year Bachelor of Computer Science student at RMIT University. Yashwin has a strong interest in data science and how it can translate into powerful insights in scientific research, business, health, and other crucial cutting-edge industries. Yashwin's other interests include Entrepreneurship, Artificial Intelligence, IOS Application Development, table tennis, and calisthenics.")
    }
    

//enum StudentDeveloper:String{
//
//    case RubyRio = "Ruby Rio", AlexanderLoMoro = "Alexander LoMoro",
//    AlexandarKotevski = "Alexandar Kotevski", YashwinSudarshan = "Yashwin Sudarshan"
//
//    var imageName:String{
//
//        switch self{
//
//            case .RubyRio: return "rubyrio"
//
//            case .AlexanderLoMoro: return "alexanderlomoro"
//
//            case .AlexandarKotevski: return "alexandarkotevski"
//
//            case .YashwinSudarshan: return "yashwinsudarshan"
//        }
//    }
//
//    var description:String{
//
//        switch self{
//
//        case .RubyRio: return "Ruby Rio is a second-year Bachelor of Software Engineering student at RMIT University. Ruby has a keen interest in Project Management in relation of Information Technology Projects, and to see how this area can develop. Ruby's other interests include Business Systems, Law, Piano and Fitness."
//
//        case .AlexanderLoMoro: return "Alexander LoMoro is a second-year Bachelor of Technology (Computing Studies) student at RMIT University. Alexander has a keen interest in UX Design, escpecially in mobile environments. Other interests of Alexander include cars, technology & sports."
//
//        case .AlexandarKotevski: return "Alexandar Kotevski is a final-year Bachelor of Information Technology student at RMIT University. Alexandar is interested in mobile app and web development. Alexandar's other interests include Apple, weather and aviation."
//
//        case .YashwinSudarshan: return "Yashwin Sudarshan is a second-year Bachelor of Computer Science student at RMIT University. Yashwin has a strong interest in data science and how it can translate into powerful insights in scientific research, business, health, and other crucial cutting-edge industries. Yashwin's other interests include Entrepreneurship, Artificial Intelligence, IOS Application Development, table tennis, and calisthenics."
//        }
//    }
//}

}
