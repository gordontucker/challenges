//
//  WordFunnelTest.swift
//  JaneChallengesTests
//
//  Created by Gordon Tucker on 11/9/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import XCTest
import JaneChallenges

class WordFunnelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOne() {
        XCTAssertTrue(WordFunnel.funnel("leave", "eave"))
        XCTAssertTrue(WordFunnel.funnel("leave", "leav"))
        XCTAssertTrue(WordFunnel.funnel("reset", "rest"))
        XCTAssertTrue(WordFunnel.funnel("dragoon", "dragon"))
        XCTAssertFalse(WordFunnel.funnel("eave", "leave"))
        XCTAssertFalse(WordFunnel.funnel("sleet", "lets"))
        XCTAssertFalse(WordFunnel.funnel("skiff", "ski"))
    }

    func testBonus_dragoon() {
        let results = WordFunnel.bonus("dragoon")
        XCTAssertEqual(1, results.count)
    }
    
    func testBonus_boats() {
        let results = WordFunnel.bonus("boats")
        XCTAssertEqual(5, results.count)
    }
    
    func testBonus_affidavit() {
        let results = WordFunnel.bonus("affidavit")
        XCTAssertEqual(0, results.count)
    }
    
    func testBonus2() {
        let results = WordFunnel.bonus2()
        XCTAssertEqual(28, results.count)
        print(results)
    }
}
