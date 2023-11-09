//
//  Calculator.swift
//  Kalculator
//
//  Created by Adil Saleem on 30/10/2023.
//  Copyright © 2023 Jogendra Singh. All rights reserved.
//

import Foundation


enum CalculatorOperation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case equals = "="
}

enum CalculatorError:Error{
    case illegalOperation
    case invalidDigit
}

class Calculator {
    var currentNumber: String = ""
    var result: Int = 0
    var currentOperation: CalculatorOperation?
    var lastOperatorInput:String = ""
    
    func inputDigit(_ digit: String) throws -> String {
        if let operation = CalculatorOperation(rawValue: digit) {
            guard lastOperatorInput != digit  else {
                return currentNumber
            }
            
            try performOperation(operation)
            lastOperatorInput = digit
            return "\(result)"
        } else {
            try appendDigit(digit)
            return currentNumber
        }
        
    }

    func appendDigit(_ digit: String) throws {
        if let newNumber = Int("\(currentNumber)\(digit)") {
            currentNumber = "\(newNumber)"
        } else {
            throw CalculatorError.invalidDigit
        }
    }

    func addOperation() {
        result += (Int(currentNumber) ?? 0)
    }

    func subtractOperation() {
        result -= (Int(currentNumber) ?? 0)
    }

    func multiplyOperation() {
        result *= (Int(currentNumber) ?? 0)
    }

    func divideOperation() throws {
        if currentNumber == "" || Int(currentNumber) == 0 {
            clear()
            throw CalculatorError.illegalOperation
        }
        
        result /= (Int(currentNumber) ?? 0)
    }

    func equalsOperation() {
        //does nothing
    }

    func performOperation(_ operation: CalculatorOperation) throws {
        switch currentOperation {
        case .add:
            addOperation()
        case .subtract:
            subtractOperation()
        case .multiply:
            multiplyOperation()
        case .divide:
            try divideOperation()
        case .equals:
            equalsOperation()
        case .none:
            result = (Int(currentNumber) ?? 0)
        }
        
        currentOperation = operation
        currentNumber = "0"
    }

    
    func clear() {
        currentNumber = ""
        result = 0
        currentOperation = nil
    }
}
