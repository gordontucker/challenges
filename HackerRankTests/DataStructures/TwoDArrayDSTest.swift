//
//  TwoDArrayDS.swift
//  HackerRankTests
//
//  Created by Gordon Tucker on 3/2/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import XCTest
@testable import HackerRank

class TwoDArrayDS: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSample() {
        
        let reader = ArrayReader([
            "1 1 1 0 0 0",
            "0 1 0 0 0 0",
            "1 1 1 0 0 0",
            "0 0 2 4 4 0",
            "0 0 0 2 0 0",
            "0 0 1 2 4 0"
            ])
        
        let writer = ArrayWriter()
        
        let test = TwoD_array(reader: reader, writer: writer)
        test.run()
        
        XCTAssertEqual("19", writer.lines.first)
    }
    
    func testSample2() {
        let reader = ArrayReader([
            "1 1 1 0 0 0",
            "0 1 0 0 0 0",
            "1 1 1 0 0 0",
            "0 9 2 -4 -4 0",
            "0 0 0 -2 0 0",
            "0 0 -1 -2 -4 0"
            ])
        
        let writer = ArrayWriter()
        
        let test = TwoD_array(reader: reader, writer: writer)
        test.run()
        
        XCTAssertEqual("13", writer.lines.first)
    }
}
