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
    
    override func setUpWithError() throws
    {
        calculator = Calculator()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws
    {
        calculator = nil
    }
    
    
    //Testing input digit function
    func test_inputDigit()
    {
        //2 digits
        try! calculator.inputDigit("5")
        try! calculator.inputDigit("5")
        XCTAssertEqual(calculator.currentNumber, "55")
        
        calculator.clear()
        //1 digit and 1 operator
        XCTAssertEqual(try! calculator.inputDigit("5"), "5")
        try! calculator.inputDigit("+")
        XCTAssertEqual(calculator.lastOperatorInput, "+")
        XCTAssertEqual(calculator.currentOperation, CalculatorOperation.add)
        
        calculator.clear()
        //1 operator then 1 digit
        try! calculator.inputDigit("+")
        try! calculator.inputDigit("5")
        XCTAssertEqual(calculator.currentNumber, "5")
        XCTAssertEqual(calculator.lastOperatorInput, "+")
        XCTAssertEqual(calculator.currentOperation, nil)
        
        //both operators, recent one is applied to operands
        try! calculator.inputDigit("+")
        try! calculator.inputDigit("-")
        XCTAssertEqual(calculator.lastOperatorInput, "-")
        XCTAssertEqual(calculator.currentOperation, CalculatorOperation.subtract)
        
        //both operators same
        try! calculator.inputDigit("+")
        try! calculator.inputDigit("+")
        XCTAssertEqual(calculator.currentOperation, CalculatorOperation.add)
    }

    //Testing append digits functions
    func test_appendDigit()
    {
        //2 digits appended
        calculator.currentNumber = "1"
        try! calculator.appendDigit("3")
        XCTAssertEqual(calculator.currentNumber, "13")
        
        //1 digit and 1 operator appended
        calculator.currentNumber = "1"
        XCTAssertThrowsError(try calculator.appendDigit("+"))
    }
    
    //Testing addition function
    func test_addOperation()
    {
        //adding two digits
        calculator.result = 5
        calculator.currentNumber = "6"
        calculator.addOperation()
        XCTAssertEqual(calculator.result, 11)
        
        //adding digit with equals
        calculator.result = 5
        calculator.currentNumber = "="
        calculator.addOperation()
        XCTAssertEqual(calculator.result, 5)
    }

    //Testing subtraction function
    func test_subtractOperation()
    {
        //subtracting two digits, digit1>digit2
        calculator.result = 5
        calculator.currentNumber = "4"
        calculator.subtractOperation()
        XCTAssertEqual(calculator.result, 1)
        
        //subtracting two digits, digit1<digit2
        calculator.result = 5
        calculator.currentNumber = "6"
        calculator.subtractOperation()
        XCTAssertEqual(calculator.result, -1)
        
        //subtracting digit with equals
        calculator.result = 5
        calculator.currentNumber = "="
        calculator.subtractOperation()
        XCTAssertEqual(calculator.result, 5)
    }

    func test_multiplyOperation()
    {
        //multiplying two digits, positive and negative
        calculator.result = 5
        calculator.currentNumber = "-4"
        calculator.multiplyOperation()
        XCTAssertEqual(calculator.result, -20)
        
        //multiplying two digits, positive and positive
        calculator.result = 5
        calculator.currentNumber = "5"
        calculator.multiplyOperation()
        XCTAssertEqual(calculator.result, 25)
        
        //multiplying two digits, negative and negative
        calculator.result = -5
        calculator.currentNumber = "-6"
        calculator.multiplyOperation()
        XCTAssertEqual(calculator.result, 30)
        
        //multiplying with equals sign
        calculator.result = 5
        calculator.currentNumber = "="
        calculator.multiplyOperation()
        XCTAssertEqual(calculator.result, 0)
    }

    func test_divideOperation()
    {
        //dividing two digits, positive and positive
        calculator.result = 5
        calculator.currentNumber = "5"
        try! calculator.divideOperation()
        XCTAssertEqual(calculator.result, 1)
        
        //dividing two digits, positive and negative
        calculator.result = -5
        calculator.currentNumber = "5"
        try! calculator.divideOperation()
        XCTAssertEqual(calculator.result, -1)
        
        //dividingtwo digits, negative and negative
        calculator.result = -5
        calculator.currentNumber = "-5"
        try! calculator.divideOperation()
        XCTAssertEqual(calculator.result, 1)
        
        //dividing with zero
        calculator.result = 5
        calculator.currentNumber = "0"
        XCTAssertThrowsError(try calculator.divideOperation())
        
        //dividing by nothing
        calculator.result = 5
        calculator.currentNumber = ""
        XCTAssertThrowsError(try calculator.divideOperation())
    }
        
    func test_equalsOperation()
    {
        XCTAssertNoThrow(calculator.equalsOperation())
    }

    func test_performOperation()
    {
        calculator.result = 9
        calculator.currentNumber = "9"
        calculator.currentOperation = .add
        try! calculator.inputDigit("=")
        XCTAssertEqual(calculator.result, 18)
        
        calculator.result = 0
        calculator.currentNumber = "0"
        calculator.currentOperation = .divide
        XCTAssertThrowsError(try calculator.performOperation(.equals))
    }

    
    func test_clear()
    {
        calculator.result = 6
        calculator.currentNumber = "7"
        calculator.lastOperatorInput = "+"
        calculator.currentOperation = .add
        calculator.clear()
        XCTAssertEqual(calculator.result, 0)
        XCTAssertEqual(calculator.currentNumber, "")
        XCTAssertEqual(calculator.currentOperation, nil)
    }

}
