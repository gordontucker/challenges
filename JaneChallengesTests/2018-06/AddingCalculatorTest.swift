//
//  AddingCalculatorTest.swift
//  JaneChallengesTests
//
//  Created by Gordon Tucker on 6/15/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import XCTest
import JaneChallenges

infix operator -+

class AddingCalculatorTest: XCTestCase {

    func testSubtract() {
        XCTAssertEqual(70, AddingCalculator.subtract(100, 30))
        XCTAssertEqual(130, AddingCalculator.subtract(100, -30))
        XCTAssertEqual(-54, AddingCalculator.subtract(-25, 29))
        XCTAssertEqual(-31, AddingCalculator.subtract(-41, -10))
    }
    
    func testMultiply() {
        XCTAssertEqual(27, AddingCalculator.multiply(9, 3))
        XCTAssertEqual(-36, AddingCalculator.multiply(9, -4))
        XCTAssertEqual(-32, AddingCalculator.multiply(-4, 8))
        XCTAssertEqual(108, AddingCalculator.multiply(-12, -9))
    }
    
    func testPower() {
        XCTAssertEqual(125, AddingCalculator.powerOf(5, 3))
        XCTAssertEqual(-125, AddingCalculator.powerOf(-5, 3))
        XCTAssertEqual(-512, AddingCalculator.powerOf(-8, 3))
        XCTAssertEqual(-1, AddingCalculator.powerOf(-1, 1))
        XCTAssertEqual(1, AddingCalculator.powerOf(1, 1))
        XCTAssertEqual(0, AddingCalculator.powerOf(0, 5))
        XCTAssertEqual(1, AddingCalculator.powerOf(5, 0))
        XCTAssertNil(AddingCalculator.powerOf(10, -3))
    }

    func testDivide() {
        XCTAssertEqual(50, AddingCalculator.divide(100, 2)?.result)
        XCTAssertEqual(0, AddingCalculator.divide(100, 2)?.remainder)
        
        XCTAssertEqual(-25, AddingCalculator.divide(75, -3)?.result)
        XCTAssertEqual(0, AddingCalculator.divide(75, -3)?.remainder)
        
        XCTAssertEqual(-25, AddingCalculator.divide(-75, 3)?.result)
        XCTAssertEqual(0, AddingCalculator.divide(-75, 3)?.remainder)
        
        XCTAssertEqual(2, AddingCalculator.divide(7, 3)?.result)
        XCTAssertEqual(1, AddingCalculator.divide(7, 3)?.remainder)
        
        XCTAssertNil(AddingCalculator.divide(0, 0))
    }
    
    func testMultiplyFloat() {
        XCTAssertEqual("\(9.06)", "\(AddingCalculator.multiply(3.02, 3))")
        XCTAssertEqual("\(11.2)", "\(AddingCalculator.multiply(3.5, 3.2))")
    }
    
}
