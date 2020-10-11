//
//  RecipeSolvedUITests.swift
//  RecipeSolvedUITests
//
//  Created by Alexander LoMoro on 30/7/20.
//  Copyright © 2020 Alexander LoMoro. All rights reserved.
//

import XCTest

class RecipeSolvedUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testElementPresence() {        // Test to make sure that the main page has the correct elements present
        let app = XCUIApplication()
        
        let numButtons = app.buttons.count
        let numLabels = app.staticTexts.count
        let numTables = app.tables.count
        
        XCTAssertEqual(numButtons, 4)
        XCTAssertEqual(numLabels, 3)
        XCTAssertEqual(numTables, 1)
        
    }
    
    func testGoodLabel() {      // Tests the label "Good" is there and correctly displayed
        let app = XCUIApplication()
        let lastLabel = app.staticTexts["goodLabel"]
        XCTAssertEqual(lastLabel.label, "Good")
    }
    
    func testTimeOfDayLabel() {
        let app = XCUIApplication()
        let lastLabel = app.staticTexts["timeOfDayLabel"]
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        // Ensure the result display is correct base on the time of day
        switch hour {
        case 0..<12 : XCTAssertEqual(lastLabel.label, "Morning")       // Show morning if time is AM
        case 12..<18 : XCTAssertEqual(lastLabel.label, "Afternoon")    // Show afternoon if time is between 12PM and 6PM
        case 18..<24 : XCTAssertEqual(lastLabel.label, "Evening")    // Show evening if time is after 6PM
        default: XCTAssertEqual(lastLabel.label, "Day")                // Default to Day if time of day cannot be found
        }
    }
    
    func testTempLabel() { // Tests the label "tempLabel" is there and correctly displayed (any value will mean the API loaded successfully)
        let app = XCUIApplication()
        
        sleep(5)    //Allows API enough time to load
        
        let lastLabel = app.staticTexts["tempLabel"]
        XCTAssertNotEqual(lastLabel.label, "-ºC")       // If the API doesn't work the label will remain the same, hence the use of NotEqual
    }
    
    func testUseCaseHomeTabRecipies () {
        // Run initial tests before proceeding with use case
        testElementPresence()
        testGoodLabel()
        testTimeOfDayLabel()
        testTempLabel()
        
        let app = XCUIApplication()
        
        // Tap the first recipe
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        let numButtons = app.buttons.count
        let numLabels = app.label.count
        let numImages = app.images.count
        XCTAssertEqual(numButtons, 6)
        XCTAssertEqual(numLabels, 12)
        XCTAssertNotEqual(numImages, 0)
        
        sleep(3)
        
        XCUIApplication().buttons["Open Recipe"].tap()
    }
    
    func testUseCaseSearch() {
        // Run initial tests before proceeding with use case
        testElementPresence()
        testGoodLabel()
        testTimeOfDayLabel()
        testTempLabel()
        
        let app = XCUIApplication()
        
        sleep(5)    //Allows UI enough time to load
        
        XCUIApplication().buttons["Explore"].tap()      // Tap Explore
        
        sleep(2)
        
        XCUIApplication().searchFields["Search Recipes"].tap() // Tap Search Field
        
        sleep(2)
        
        XCTAssert(app.keyboards.count > 0, "The keyboard is not shown")     // Report if keyboard is not shown
        XCUIApplication().searchFields["Search Recipes"].typeText("Chicken")        // Search for chicken (can be anything)
        
        sleep(2)
        
        app.keyboards.buttons["Search"].tap()       // Tap search on the software keyboard
        
        sleep(10)       // Allows enough time of the API to return results
    }
    
    func testUseCaseAddToPantry() {
        // Run initial tests before proceeding with use case
        testElementPresence()
        testGoodLabel()
        testTimeOfDayLabel()
        testTempLabel()
        
        let app = XCUIApplication()
        
        sleep(5)    //Allows UI enough time to load
        
        // Go to pantry tab
        XCUIApplication().buttons["Pantry"].tap()
        
        sleep(2)
        
        // Open ingredient adding page
        XCUIApplication().buttons["+ Add"].tap()
        
        sleep(2)
        
        // Check for presence of elements
        let numButtons = app.buttons.count
        let numLabels = app.label.count
        let numTextFields = app.textFields.count
        XCTAssertEqual(numButtons, 6)
        XCTAssertEqual(numLabels, 12)
        XCTAssertEqual(numTextFields, 3)
        
        // Check Text Fields present correctly
        let label1 = app.staticTexts["Ingredient:"]
        XCTAssertEqual(label1.label, "Ingredient:")
        let label2 = app.staticTexts["Quantity:"]
        XCTAssertEqual(label2.label, "Quantity:")
        let label3 = app.staticTexts["Expiry:"]
        XCTAssertEqual(label3.label, "Expiry:")
        
        // Fill out the fields
        XCUIApplication().textFields["Ingredient"].tap()
        XCUIApplication().textFields["Ingredient"].typeText("Eggs")
        sleep(1)
        XCUIApplication().textFields["Quantity"].tap()
        XCUIApplication().textFields["Quantity"].typeText("12")
        sleep(1)
        XCUIApplication().textFields["Expiry"].tap()
        XCUIApplication().textFields["Expiry"].typeText("12/10/20")
        
        sleep(2)
        
        // Enter ingredient into database
        XCUIApplication().buttons["Confirm Entry"].tap()
        
        // Final wait to visually inspect task has worked successfully
        sleep(10)
        
    }
    
    func testUseCaseProfiles() {
        testElementPresence()
        testGoodLabel()
        testTimeOfDayLabel()
        testTempLabel()
        
        let app = XCUIApplication()
        
        sleep(5)    //Allows UI enough time to load
        
        XCUIApplication().buttons["Profiles"].tap()
        
        sleep(2)
        
        // Tap the first profile
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        sleep(2)
        
        // Check for presence of elements
        let numButtons = app.buttons.count
        let numLabels = app.label.count
        let numImages = app.images.count
        XCTAssertEqual(numButtons, 5)
        XCTAssertEqual(numLabels, 12)
        XCTAssertNotEqual(numImages, 0)
        
        XCUIApplication().buttons["Development Team"].tap()
        
        sleep(2)
        
        // Tap the second profile
        app.tables.element(boundBy: 0).cells.element(boundBy: 1).tap()
        
        sleep(2)
        
        // Check for presence of elements
        let numButtons1 = app.buttons.count
        let numLabels1 = app.label.count
        let numImages1 = app.images.count
        XCTAssertEqual(numButtons1, 5)
        XCTAssertEqual(numLabels1, 12)
        XCTAssertNotEqual(numImages1, 0)
        
        XCUIApplication().buttons["Development Team"].tap()
        
        sleep(2)
        
        // Tap the third profile
        app.tables.element(boundBy: 0).cells.element(boundBy: 2).tap()
        
        sleep(2)
        
        // Check for presence of elements
        let numButtons2 = app.buttons.count
        let numLabels2 = app.label.count
        let numImages2 = app.images.count
        XCTAssertEqual(numButtons2, 5)
        XCTAssertEqual(numLabels2, 12)
        XCTAssertNotEqual(numImages2, 0)
        
        XCUIApplication().buttons["Development Team"].tap()
        
        sleep(2)
        
        // Tap the forth profile
        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()
        
        sleep(2)
        
        // Check for presence of elements
        let numButtons3 = app.buttons.count
        let numLabels3 = app.label.count
        let numImages3 = app.images.count
        XCTAssertEqual(numButtons3, 5)
        XCTAssertEqual(numLabels3, 12)
        XCTAssertNotEqual(numImages3, 0)
        
        XCUIApplication().buttons["Development Team"].tap()
        
        sleep(5)
    }
}
