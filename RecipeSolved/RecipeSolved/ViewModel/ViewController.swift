//
//  ViewController.swift
//  RecipeSolved
//
//  Created by Alexander LoMoro on 30/7/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Label outlets for temperature
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var item: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeather()
        getGreeting()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func getGreeting()  {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 0..<12 : self.greetingLabel.text = "Morning"       // Show morning if time is AM
        case 12..<18 : self.greetingLabel.text = "Afternoon"    // Show afternoon if time is between 12PM and 6PM
        case 18..<24 : self.greetingLabel.text = "Evening"    // Show evening if time is after 6PM
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
                            if let temperature = mainDictionary.value(forKey: "temp") as? Double {
                                let temp = Int(temperature)
                                DispatchQueue.main.async {
                                    self.currentTempLabel.text = "\(temp)ºC"     // Updates the currentTempLabel
                                }
                            }
                            if let temperature = mainDictionary.value(forKey: "temp_max") as? Double {
                                let temp = Int(temperature)
                                DispatchQueue.main.async {
                                    self.maxTempLabel.text = "\(temp)ºC"         // Updates the maxTempLabel
                                }
                            }
                            if let temperature = mainDictionary.value(forKey: "temp_min") as? Double {
                                let temp = Int(temperature)
                                DispatchQueue.main.async {
                                    self.minTempLabel.text = "\(temp)ºC"         // Updates the minTempLabel
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

    
//  Table
    
    private let viewModel = RecipeViewModel()


      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return viewModel.count
      }

    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
          let imageView = cell.viewWithTag(1000) as? UIImageView
          let recipeTitle = cell.viewWithTag(1001) as? UILabel
          let recipeTime = cell.viewWithTag(1002) as? UILabel
          let recipeItems = cell.viewWithTag(1003) as? UILabel
          let recipeRating = cell.viewWithTag(1004) as? UILabel
          
          if let imageView = imageView, let recipeTitle = recipeTitle, let recipeTime = recipeTime, let recipeItems = recipeItems, let recipeRating = recipeRating{
              let currentRecipe = viewModel.getRecipe(byIndex: indexPath.row)
              imageView.image = currentRecipe.image
              recipeTitle.text = currentRecipe.title
              recipeTime.text = currentRecipe.time
              recipeItems.text = currentRecipe.items
              recipeRating.text = currentRecipe.rating
          }
          return cell
      }


      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
          guard let selectedRow = self.tableView.indexPathForSelectedRow else{return}

          let destination = segue.destination as? RecipeViewController
          
          let selectedRecipe = viewModel.getRecipe(byIndex: selectedRow.row)
          
          destination?.selectedRecipe = selectedRecipe
      }
    
}

