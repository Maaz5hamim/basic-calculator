//
//  KalculatorUITests.swift
//  KalculatorUITests
//
//  Created by Adil Saleem on 31/10/2023.
//  Copyright © 2023 Jogendra Singh. All rights reserved.
//

import XCTest

final class KalculatorUITests: XCTestCase
{
    var app : XCUIApplication!
    override func setUpWithError() throws
    {
        // UI tests must launch the application that they test.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws
    {
        app.terminate()
    }
    
    // Tests the visibility of Numpad
    func test_buttonsVisibility()
    {
        XCTAssertTrue(app.buttons["0"].exists)
        XCTAssertTrue(app.buttons["1"].exists)
        XCTAssertTrue(app.buttons["2"].exists)
        XCTAssertTrue(app.buttons["3"].exists)
        XCTAssertTrue(app.buttons["4"].exists)
        XCTAssertTrue(app.buttons["5"].exists)
        XCTAssertTrue(app.buttons["6"].exists)
        XCTAssertTrue(app.buttons["7"].exists)
        XCTAssertTrue(app.buttons["8"].exists)
        XCTAssertTrue(app.buttons["9"].exists)

        XCTAssertTrue(app.buttons["+"].exists)
        XCTAssertTrue(app.buttons["-"].exists)
        XCTAssertTrue(app.buttons["*"].exists)
        XCTAssertTrue(app.buttons["/"].exists)
        XCTAssertTrue(app.buttons["="].exists)
        XCTAssertTrue(app.buttons["C"].exists)
    }
    
    //Tests the visibility of the Basic Calculator label
    func test_labelVisibility()
    {
        XCTAssertTrue(app.staticTexts["Basic Calculator"].exists)
    }

    func test_resultVisibility()
    {
        //testing the visibility of the result screen label
        XCTAssertTrue(app.staticTexts["Result Screen"].exists)

        //testing the Clear key
        app.buttons["1"].tap()
        app.buttons["C"].tap()
        XCTAssertEqual(app.staticTexts["Result Screen"].label, "0")

        //testing the visibility of each number after pressed
        var button:String
        for number in 0...9
        {
            button = String(number)
            app.buttons[button].tap()
            XCTAssertEqual(app.staticTexts["Result Screen"].label, button)
            app.buttons["C"].tap()
        }
    }

    //Tests the correctness of the values of the Result Screen label
    func test_resultCorrectness()
    {
        //testing the results of each operation
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["1"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(app.staticTexts["Result Screen"].label, "2")

        app.buttons["C"].tap()
        app.buttons["1"].tap()
        app.buttons["-"].tap()
        app.buttons["1"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(app.staticTexts["Result Screen"].label, "0")

        app.buttons["C"].tap()
        app.buttons["2"].tap()
        app.buttons["*"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(app.staticTexts["Result Screen"].label, "6")

        app.buttons["C"].tap()
        app.buttons["8"].tap()
        app.buttons["/"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(app.staticTexts["Result Screen"].label, "4")

        app.buttons["C"].tap()
        //Testing Divide-by-Zero Error
        app.buttons["1"].tap()
        app.buttons["/"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(app.staticTexts["Result Screen"].label, "Err")
        
        app.buttons["C"].tap()
        //Testing one oper
        app.buttons["1"].tap()
        app.buttons["1"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(app.staticTexts["Result Screen"].label, "11")
        
        
    }
}

