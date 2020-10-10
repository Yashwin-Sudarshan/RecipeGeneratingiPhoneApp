//
//  ViewController.swift
//  RecipeSolved
//
//  Created by Alexander LoMoro on 30/7/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, RefreshHome {
    
    // Label outlets for temperature
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // Models and managers
    private var ingredientManager = DataManager.shared
    private var viewModel = HomeRecipeViewModel()
    let locationManager = CLLocationManager()
    
    // Update table view
    func updateHome() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Check for location permissions
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // Call helper functions to get data
        getWeather()
        getGreeting()
        // Set delegates
        viewModel.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Get ingredients from data store.
        var ingredientName: String{
            
            var result: String = ""
            let ingredients = ingredientManager.ingredients
            for(_, ingredient) in ingredients.enumerated(){
                
                if let name = ingredient.name{
                    result += name + ","
                }
            }
            return result
        }
        // Create activity indicator
        let loadingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.backgroundView = loadingSpinner
        loadingSpinner.startAnimating()
        // Use ingreidents from pantry to populate the table, if there are no ingredients in the pantry, randomly select recipes.
        if ingredientName.isEmpty {
            viewModel.getRandomRecipe()
        }
        else {
            viewModel.getRecipe(title: ingredientName)
        }
        
    }
    
    // Get the user's current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
        }
        manager.stopUpdatingLocation()
    }
    
    // Show error if the user's location could not be determined.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }
    
    // Create greeting label based on time of day.
    func getGreeting()  {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 0..<12 : self.greetingLabel.text = "Morning"       // Show morning if time is AM
        case 12..<18 : self.greetingLabel.text = "Afternoon"    // Show afternoon if time is between 12PM and 6PM
        case 18..<24 : self.greetingLabel.text = "Evening"    // Show evening if time is after 6PM
        default: self.greetingLabel.text = "Day"                // Default to Day if time of day cannot be found
        }
    }
    
    // Get the user's local weather based on the user's location.
    func getWeather() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation();
        }
        let lat = "\(locationManager.location?.coordinate.latitude ?? -38)"
        let lon = "\(locationManager.location?.coordinate.longitude ?? 145)"
        let session = URLSession.shared
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&APPID=368e3231ebc2330d34a01ab4e56add0e")!
        
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

    
    // Calculate the number of rows for the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    // Draw the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let imageView = cell.viewWithTag(1000) as! UIImageView
        let recipeTitle = cell.viewWithTag(1001) as! UILabel
        let recipeItems = cell.viewWithTag(1003) as! UILabel
        let recipeServings = cell.viewWithTag(1004) as! UILabel
        
        imageView.image = viewModel.getImageFor(index: indexPath.row)
        recipeTitle.text = viewModel.getTitleFor(index: indexPath.row)
        recipeItems.text = viewModel.getItemsFor(index: indexPath.row)
        recipeServings.text = viewModel.getServingsFor(index: indexPath.row)
        
        return cell
      }

    // Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedRow = self.tableView.indexPathForSelectedRow else {return}
        let destination = segue.destination as? RecipeViewController
        let selectedRecipe = viewModel.getAllFor(index: selectedRow.row)
        destination?.selectedRecipe = selectedRecipe
    }

}
