//
//  VideoPathTests.swift
//  PlayLocalVideoTests
//
//  Created by QDSG on 2019/9/30.
//  Copyright © 2019 unitTao. All rights reserved.
//

import XCTest
@testable import PlayLocalVideo

class VideoPathTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let path1 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let path2 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        
        XCTAssertNotNil(path1?.absoluteString)
        XCTAssertNotNil(path2)
        
        XCTAssertEqual((path1?.absoluteString)!, "file://\(path2!)/")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
