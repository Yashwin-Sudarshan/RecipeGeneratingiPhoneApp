//
//  RecipeSolvedUnitTests.swift
//  RecipeSolvedUnitTests
//
//  Created by Alexander LoMoro on 10/10/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import XCTest
@testable import RecipeSolved

class RecipeSolvedUnitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Unit test 1: Check weather label updates based on data that is passed to it
    func testWeatherUpdating() {
        var currentTemp = 0     // Set temp to 0
        var tempLabel = "\(currentTemp)ºc"      // Update temp label with the same style logic in ViewController
        
        XCTAssertEqual(tempLabel, "0ºc")        // Test to see label has update correctly
        
        // Repeat with new temp
        currentTemp = 2
        tempLabel = "\(currentTemp)ºc"
        XCTAssertEqual(tempLabel, "2ºc")
        
        // Repeat with new temp
        currentTemp = 18
        tempLabel = "\(currentTemp)ºc"
        XCTAssertEqual(tempLabel, "18ºc")
    }

    // Unit test 2: Check Morning is displayed when time is in AM
    func testGreetingStringMorning() {
        // Test with hour set to 0..11
        var text = ""
        
        for i in 0...11 {
            switch i {
            case 0..<12 : text = "Morning"       // Show morning if time is AM
            case 12..<18 : text = "Afternoon"    // Show afternoon if time is between 12PM and 6PM
            case 18..<24 : text = "Evening"    // Show evening if time is after 6PM
            default: text = "Day"                // Default to Day if time of day cannot be found
            }
            
            XCTAssertEqual(text, "Morning")
        }
    }
    
    // Unit test 3: Check Evening is displayed when time is in betwen 12PM & 5PM
    func testGreetingStringAfternoon() {
        // Test with hour set from 12..<18
        var text = ""
        
        for i in 12...17 {
            switch i {
            case 0..<12 : text = "Morning"       // Show morning if time is AM
            case 12..<18 : text = "Afternoon"    // Show afternoon if time is between 12PM and 6PM
            case 18..<24 : text = "Evening"    // Show evening if time is after 6PM
            default: text = "Day"                // Default to Day if time of day cannot be found
            }
            
            XCTAssertEqual(text, "Afternoon")
        }
    }
    
    // Unit test 4: Check Evening is displayed when time is in betwen 5PM & 11:59PM
    func testGreetingStringEvening() {
        // Test with hour set from 18..<24
        var text = ""
        
        for i in 18...23 {
            switch i {
            case 0..<12 : text = "Morning"       // Show morning if time is AM
            case 12..<18 : text = "Afternoon"    // Show afternoon if time is between 12PM and 6PM
            case 18..<24 : text = "Evening"    // Show evening if time is after 6PM
            default: text = "Day"                // Default to Day if time of day cannot be found
            }
            
            XCTAssertEqual(text, "Evening")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
