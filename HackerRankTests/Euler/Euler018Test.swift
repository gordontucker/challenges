//
//  Euler018Test.swift
//  HackerRankTests
//
//  Created by Gordon Tucker on 2/16/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import XCTest
@testable import HackerRank

class Euler018Test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1() {
        // This is an example of a performance test case.
        self.measure {
            
            let reader = ArrayReader([
                "1",
                "4",
                "3",
                "7 4",
                "2 4 6",
                "8 5 9 3"
            ])
            
            let writer = ArrayWriter()
            
            let euler18 = Euler018(reader: reader, writer: writer)
            euler18.run()
            
            XCTAssertEqual("23", writer.lines.first)
        }
    }
    
    func test2() {
        // This is an example of a performance test case.
        self.measure {
            
            let reader = ArrayReader([
                "1",
                "4",
                "3",
                "7 4",
                "2 4 6",
                "8 5 9 1000"
                ])
            
            let writer = ArrayWriter()
            
            let euler18 = Euler018(reader: reader, writer: writer)
            euler18.run()
            
            XCTAssertEqual("1013", writer.lines.first)
        }
    }
    
    func test3() {
        // This is an example of a performance test case.
        self.measure {
            
            let reader = ArrayReader([
                "1",
                "4",
                "0",
                "0 0",
                "0 0 0",
                "8 5 9 0"
                ])
            
            let writer = ArrayWriter()
            
            let euler18 = Euler018(reader: reader, writer: writer)
            euler18.run()
            
            XCTAssertEqual("9", writer.lines.first)
        }
    }
    
}
