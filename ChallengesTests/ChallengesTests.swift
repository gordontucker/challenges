//
//  ChallengesTests.swift
//  ChallengesTests
//
//  Created by Gordon Tucker on 2/16/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import XCTest
@testable import Challenges

class ChallengesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.

        XCTAssertEqual("All, the things!", HomeRowSpellCheck.spellCheck(input: "All, the things!"))
        XCTAssertEqual("All, the things!", HomeRowSpellCheck.spellCheck(input: "Lkk, yjr yjomhd!"))
        XCTAssertEqual("All, the things!", HomeRowSpellCheck.spellCheck(input: "Kjj, efq things!"))
        XCTAssertEqual("All, the things!", HomeRowSpellCheck.spellCheck(input: "All, yjr things!"))
        XCTAssertEqual("All, the things!", HomeRowSpellCheck.spellCheck(input: "All, the ukpzjf!"))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
