//
//  ColorPuzzleTest.swift
//  JaneChallengesTests
//
//  Created by Gordon Tucker on 2/16/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import XCTest
@testable import JaneChallenges

class ColorPuzzleTest: XCTestCase {
    
    func testSample() {
        let sequence = ColorPuzzle.findSequence(tiles: [
           ["W", "O", "O", "O"],
           ["B", "G", "V", "R"],
           ["R", "G", "B", "G"],
           ["V", "O", "B", "R"]
        ], targetColor: .orange)
        
        XCTAssertEqual("O G B R V O G O", sequence)
        XCTAssertLessThan(sequence.count, 49)
    }
    
    func testChallenge() {
        let sequence = ColorPuzzle.findSequence(tiles: [
            ["W", "Y", "O", "B", "V", "G", "V", "O", "Y", "B"],
            ["G", "O", "O", "V", "R", "V", "R", "G", "O", "R"],
            ["V", "B", "R", "R", "R", "B", "R", "B", "G", "Y"],
            ["B", "O", "Y", "R", "R", "G", "Y", "V", "O", "V"],
            ["V", "O", "B", "O", "R", "G", "B", "R", "G", "R"],
            ["B", "O", "G", "Y", "Y", "G", "O", "V", "R", "V"],
            ["O", "O", "G", "O", "Y", "R", "O", "V", "G", "G"],
            ["B", "O", "O", "V", "G", "Y", "V", "B", "Y", "G"],
            ["R", "B", "G", "V", "O", "R", "Y", "G", "G", "G"],
            ["Y", "R", "Y", "B", "R", "O", "V", "O", "B", "V"],
            ["O", "B", "O", "B", "Y", "O", "Y", "V", "B", "O"],
            ["V", "R", "R", "G", "V", "V", "G", "V", "V", "G"]
        ], targetColor: .violet)
        
        XCTAssertNotEqual("", sequence)
        XCTAssertLessThan(sequence.count, 50)
    }
}
