//
//  ViewController.swift
//  RecipeSolved
//
//  Created by Alexander LoMoro on 30/7/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Label outlets for temperature
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeather()
        getGreeting()
    }
    
    func getGreeting()  {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 0..<12 : self.greetingLabel.text = "Morning"       // Show morning if time is AM
        case 12..<24 : self.greetingLabel.text = "Evening"    // Show afternoon if time is PM
        default: self.greetingLabel.text = "Day"                // Default to Day if time of day cannot be found
        }
    }
    
    
    func getWeather() {
        let city = "East%20Melbourne"
        let countryCode = "au"
        let session = URLSession.shared
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city),\(countryCode)?&units=metric&APPID=368e3231ebc2330d34a01ab4e56add0e")!
        
        // API KEY: 368e3231ebc2330d34a01ab4e56add0e
        // Also hosts the location of data being retrieved
        
        let dataTask = session.dataTask(with: weatherURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error:\n\(error)")
            } else {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("All the weather data:\n\(dataString!)")     // Prints all data for location to console to ensure data was retrieved correctly
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let temperature = mainDictionary.value(forKey: "temp") {
                                DispatchQueue.main.async {
                                    self.currentTempLabel.text = "\(temperature)ºc"     // Updates the currentTempLabel
                                }
                            }
                            if let temperature = mainDictionary.value(forKey: "temp_max") {
                                DispatchQueue.main.async {
                                    self.maxTempLabel.text = "\(temperature)ºc"         // Updates the maxTempLabel
                                }
                            }
                            if let temperature = mainDictionary.value(forKey: "temp_min") {
                                DispatchQueue.main.async {
                                    self.minTempLabel.text = "\(temperature)ºc"         // Updates the minTempLabel
                                }
                            }
                        } else {
                            print("Error: unable to find temperature in dictionary")
                        }
                    } else {
                        print("Error: unable to convert json data")
                    }
                } else {
                    print("Error: did not receive data")
                }
            }
        }
        dataTask.resume()
    }

}

