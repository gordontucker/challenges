//
//  RedSquigglyTest.swift
//  JaneChallengesTests
//
//  Created by Gordon Tucker on 6/4/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import XCTest
import JaneChallenges

class RedSquigglyTest: XCTestCase {
    
    func testExample() {
        XCTAssertEqual("hello", RedSquiggly.spellCheck("hello"))
        XCTAssertEqual("hi", RedSquiggly.spellCheck("hi"))
        XCTAssertEqual("accomo<date", RedSquiggly.spellCheck("accomodate"))
        XCTAssertEqual("acknowleg<ement", RedSquiggly.spellCheck("acknowlegement"))
        XCTAssertEqual("arguem<int", RedSquiggly.spellCheck("arguemint"))
        XCTAssertEqual("comitm<ment", RedSquiggly.spellCheck("comitmment"))
        XCTAssertEqual("deducta<bel", RedSquiggly.spellCheck("deductabel"))
        XCTAssertEqual("depin<dant", RedSquiggly.spellCheck("depindant"))
        XCTAssertEqual("exista<nse", RedSquiggly.spellCheck("existanse"))
        XCTAssertEqual("forword<e", RedSquiggly.spellCheck("forworde"))
        XCTAssertEqual("herra<ss", RedSquiggly.spellCheck("herrass"))
        XCTAssertEqual("inadva<rtent", RedSquiggly.spellCheck("inadvartent"))
        XCTAssertEqual("judgema<nt", RedSquiggly.spellCheck("judgemant"))
        XCTAssertEqual("ocur<rance", RedSquiggly.spellCheck("ocurrance"))
        XCTAssertEqual("parog<ative", RedSquiggly.spellCheck("parogative"))
        XCTAssertEqual("supa<rseed", RedSquiggly.spellCheck("suparseed"))
    }
}
