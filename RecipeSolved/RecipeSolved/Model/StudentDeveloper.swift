//
//  StudentDeveloper.swift
//  RecipeSolved
//
//  Created by Yashwin Sudarshan on 30/8/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

// This struct allows for the addition of all hard coded student developers to the developer database

import Foundation

struct StudentDeveloper{
    
    private var developerManager = DataManager.shared
    private var addingDeveloperViewModel = StudentDeveloperAddDeveloperViewModel()
    
    init(){}
    
    mutating func addAllDevelopers(){
        
        addingDeveloperViewModel.addDeveloper("Ruby Rio", "rubyrio", "Ruby Rio is a second-year Bachelor of Software Engineering student at RMIT University. Ruby has a keen interest in Project Management in relation of Information Technology Projects, and to see how this area can develop. Ruby's other interests include Business Systems, Law, Piano and Fitness.")
        addingDeveloperViewModel.addDeveloper("Alexander LoMoro", "alexanderlomoro", "Alexander LoMoro is a second-year Bachelor of Technology (Computing Studies) student at RMIT University. Alexander has a keen interest in UX Design, escpecially in mobile environments. Other interests of Alexander include cars, technology & sports.")
        addingDeveloperViewModel.addDeveloper("Alexandar Kotevski", "alexandarkotevski", "Alexandar Kotevski is a final-year Bachelor of Information Technology student at RMIT University. Alexandar is interested in mobile app and web development. Alexandar's other interests include Apple, weather and aviation.")
        addingDeveloperViewModel.addDeveloper("Yashwin Sudarshan", "yashwinsudarshan", "Yashwin Sudarshan is a second-year Bachelor of Computer Science student at RMIT University. Yashwin has a strong interest in data science and how it can translate into powerful insights in scientific research, business, health, and other crucial cutting-edge industries. Yashwin's other interests include Entrepreneurship, Artificial Intelligence, IOS Application Development, table tennis, and calisthenics.")
    }
    
}
