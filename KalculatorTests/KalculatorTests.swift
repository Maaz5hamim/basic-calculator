//
//  KalculatorTests.swift
//  KalculatorTests
//
//  Created by Adil Saleem on 31/10/2023.
//  Copyright © 2023 Jogendra Singh. All rights reserved.
//

import XCTest
@testable import Kalculator

final class KalculatorTests: XCTestCase
{
    
    var calculator: Calculator!
    var vc:ViewController!
    var storyboard:UIStoryboard!
    
    override func setUpWithError() throws
    {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        _ = vc.view // To call viewDidLoad
        calculator = Calculator()
    }
    
    override func tearDownWithError() throws
    {
        calculator = nil
    }
    
    //Mark:- View Controller Tests
    
    //test to ensure input_Digit is invoked on pressing a digit on numpad
    func test_positive_inputDigitVC()
    {
        vc.inputDigit(vc.one.sendActions(for: .touchUpInside))
        XCTAssertEqual(vc.resultScreen.text, "1")
    }
    
    //Test for clear button
    func test_clearVC()
    {
        vc.inputDigit(vc.c.sendActions(for: .touchUpInside))
        XCTAssertEqual(vc.resultScreen.text, "0")
    }
    
    //Mark:- Calculator Tests
    
    //Testing input digit function
    func test_positive_inputDigit()
    {
        XCTAssertEqual(try! calculator.inputDigit("+"), "0")
        XCTAssertEqual(try! calculator.inputDigit("-"), "0")
        XCTAssertEqual(try! calculator.inputDigit("*"), "0")
        XCTAssertEqual(try! calculator.inputDigit("/"), "0")
        
        var button:String
        for number in 0...9
        {
            button = String(number)
            XCTAssertEqual(try! calculator.inputDigit(button), button)
            calculator.clear()
        }
    }
    func test_negative_inputDigit()
    {
        XCTAssertThrowsError(try calculator.inputDigit("C"), CalculatorError.invalidDigit as! String)
    }
    func test_guard_inputDigit()
    {
        XCTAssertEqual(try! calculator.inputDigit("/"), "0")
        XCTAssertEqual(try! calculator.inputDigit("/"), "0")
    }
    func test_positive_appendDigit()
    {
        _ = try! calculator.inputDigit("5")
        try! calculator.appendDigit("5")
        XCTAssertEqual(try! calculator.inputDigit("="), "55")
    }
    func test_negative_appendDigit()
    {
        _ = try! calculator.inputDigit("5")
        XCTAssertThrowsError(try calculator.appendDigit("+"), CalculatorError.invalidDigit as! String)
    }


    //Testing addition function
    func test_addOperation()
    {
        //adding two digits
        _ = try! calculator.inputDigit("5")
        _ = try! calculator.inputDigit("+")
        _ = try! calculator.inputDigit("6")
        XCTAssertEqual(try! calculator.inputDigit("="), "11")
    }

    //Testing subtraction function
    func test_subtractOperation()
    {
        //subtracting two digits, digit1>digit2
        _ = try! calculator.inputDigit("6")
        _ = try! calculator.inputDigit("-")
        _ = try! calculator.inputDigit("5")
        XCTAssertEqual(try! calculator.inputDigit("="), "1")
    }

    func test_multiplyOperation()
    {
        //multiplying two digits
        _ = try! calculator.inputDigit("6")
        _ = try! calculator.inputDigit("*")
        _ = try! calculator.inputDigit("5")
        XCTAssertEqual(try! calculator.inputDigit("="), "30")
    }

    func test_positive_divideOperation()
    {
        //dividing two digits
        _ = try! calculator.inputDigit("6")
        _ = try! calculator.inputDigit("/")
        _ = try! calculator.inputDigit("6")
        XCTAssertEqual(try! calculator.inputDigit("="), "1")
    }
    
    func test_divideOperation_Error()
    {
        //dividing by zero
        _ = try! calculator.inputDigit("1")
        _ = try! calculator.inputDigit("/")
        _ = try! calculator.inputDigit("0")
        XCTAssertThrowsError(try calculator.inputDigit("="), CalculatorError.illegalOperation as! String)
    }
    
    func test_equalsOperation()
    {
        _ = try! calculator.inputDigit("1")
        _ = try! calculator.inputDigit("/")
        _ = try! calculator.inputDigit("1")
        _ = try! calculator.inputDigit("=")
        XCTAssertEqual(try! calculator.inputDigit("*"),"1")
    } 
    }

