//
//  PancakeSortTest.swift
//  JaneChallengesTests
//
//  Created by Gordon Tucker on 3/9/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import XCTest

class PancakeSortTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func solve(_ sortType: PancakeSort.SortType, values: Int...) {
        let expected = values.sorted()
        let result = PancakeSort.run(sortType, values: values)
        XCTAssertEqual(expected.count, result.sorted.count)
        guard expected.count == result.sorted.count else { return }
        for i in 0 ..< expected.count {
            XCTAssertEqual(expected[i], result.sorted[i], "Value didn't match at \(i)")
        }
    }
    
    func testSample() {
        self.solve(.v2, values: 3,1,2)
    }
    
    func testSample2() {
        self.solve(.v2, values: 7,6,4,2,6,7,8,7)
    }
    
    func testSample3() {
        self.solve(.v2, values: 11,5,12,3,10,3,2,5)
    }
    
    func testSample4() {
        self.solve(.v2, values: 3,12,8,12,4,7,10,3,8,10)
    }
}
