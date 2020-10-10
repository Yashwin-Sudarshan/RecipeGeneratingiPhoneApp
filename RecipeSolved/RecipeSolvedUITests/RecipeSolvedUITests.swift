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

    func testElementPresence() {
        let app = XCUIApplication()
        
        let numButtons = app.buttons.count
        let numLabels = app.staticTexts.count
        let numTables = app.tables.count
        
        XCTAssertEqual(numButtons, 4)
        XCTAssertEqual(numLabels, 4)
        XCTAssertEqual(numTables, 1)
        
    }
    
    func testGoodLabel() {
        let app = XCUIApplication()
        let lastLabel = app.staticTexts["goodLabel"]
        XCTAssertEqual(lastLabel.label, "Good")
    }
    
    func testTimeOfDayLabel() {
        let app = XCUIApplication()
        let lastLabel = app.staticTexts["timeOfDayLabel"]
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12 : XCTAssertEqual(lastLabel.label, "Morning")       // Show morning if time is AM
        case 12..<18 : XCTAssertEqual(lastLabel.label, "Afternoon")    // Show afternoon if time is between 12PM and 6PM
        case 18..<24 : XCTAssertEqual(lastLabel.label, "Evening")    // Show evening if time is after 6PM
        default: XCTAssertEqual(lastLabel.label, "Day")                // Default to Day if time of day cannot be found
        }
    }
    
    func testTempLabel() {
        let app = XCUIApplication()
        
        sleep(5)    //Allows API enough time to load
        
        let lastLabel = app.staticTexts["tempLabel"]
        XCTAssertNotEqual(lastLabel.label, "-ºC")
    }
    
    func testUseCaseSearch() {
        testElementPresence()
        testGoodLabel()
        testTimeOfDayLabel()
        testTempLabel()
        
        let app = XCUIApplication()
        
        sleep(5)    //Allows UI enough time to load
        
        XCUIApplication().buttons["Explore"].tap()
        
        sleep(2)
        
        XCUIApplication().searchFields["Search Recipes"].tap()
        
        sleep(2)
        
        XCTAssert(app.keyboards.count > 0, "The keyboard is not shown")
        XCUIApplication().searchFields["Search Recipes"].typeText("Chicken")
        
        sleep(2)
        
        app.keyboards.buttons["Search"].tap()
        
        sleep(10)
    }
    
    func testUseCaseAddToPantry() {
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
    }
}
