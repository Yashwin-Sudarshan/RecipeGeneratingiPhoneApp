//
//  StudentDeveloper.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import Foundation

enum StudentDeveloper:String{
    
    case RubyRio = "Ruby Rio", AlexanderLoMoro = "Alexander LoMoro",
    AlexandarKotevski = "Alexandar Kotevski", YashwinSudarshan = "Yashwin Sudarshan"
    
    var imageName:String{
        
        switch self{
            
//            case .RubyRio: return "rubyrio"
            case .RubyRio: return "yashwinsudarshan"

            case .AlexanderLoMoro: return "yashwinsudarshan"
//            case .AlexanderLoMoro: return "alexanderlomoro"
            
            case .AlexandarKotevski: return "yashwinsudarshan"
//            case .AlexandarKotevski: return "alexandarkotevski"
            
            case .YashwinSudarshan: return "yashwinsudarshan"
        }
    }
    
    var description:String{
        
        switch self{
            
        case .RubyRio: return "Ruby Rio is a university student."
            
        case .AlexanderLoMoro: return "Alexander LoMoro is a university student."
            
        case .AlexandarKotevski: return "Alexandar Kotevski is a university student."
            
        case .YashwinSudarshan: return "Yashwin Sudarshan is a second-year Bachelor of Computer Science student at RMIT University. Yashwin has a strong interest in data science and how it can translate into powerful insights in scientific research, business, health, and other crucial cutting-edge industries. Yashwin's other interests include Entrepreneurship, Artificial Intelligence, IOS Application Development, table tennis, and calisthenics."
        }
    }
}
