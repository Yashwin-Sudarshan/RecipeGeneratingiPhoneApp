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

    func testGreetingString() {
        // Test with hour set to 1
        var hour = 1
        var text = ""
        
        switch hour {
        case 0..<12 : text = "Morning"       // Show morning if time is AM
        case 12..<18 : text = "Afternoon"    // Show afternoon if time is between 12PM and 6PM
        case 18..<24 : text = "Evening"    // Show evening if time is after 6PM
        default: text = "Day"                // Default to Day if time of day cannot be found
        }
        
        XCTAssertEqual(text, "Morning")
        
        // Test with hour set to 13
        hour = 13
        
        switch hour {
        case 0..<12 : text = "Morning"       // Show morning if time is AM
        case 12..<18 : text = "Afternoon"    // Show afternoon if time is between 12PM and 6PM
        case 18..<24 : text = "Evening"    // Show evening if time is after 6PM
        default: text = "Day"                // Default to Day if time of day cannot be found
        }
        
        XCTAssertEqual(text, "Afternoon")
        
        // Test with hour set to 19
        hour = 19
        
        switch hour {
        case 0..<12 : text = "Morning"       // Show morning if time is AM
        case 12..<18 : text = "Afternoon"    // Show afternoon if time is between 12PM and 6PM
        case 18..<24 : text = "Evening"    // Show evening if time is after 6PM
        default: text = "Day"                // Default to Day if time of day cannot be found
        }
        
        XCTAssertEqual(text, "Evening")
        
        // Test with hour set to 25 (outside of scope) should go default
        hour = 25
        
        switch hour {
        case 0..<12 : text = "Morning"       // Show morning if time is AM
        case 12..<18 : text = "Afternoon"    // Show afternoon if time is between 12PM and 6PM
        case 18..<24 : text = "Evening"    // Show evening if time is after 6PM
        default: text = "Day"                // Default to Day if time of day cannot be found
        }
        
        XCTAssertEqual(text, "Day")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
