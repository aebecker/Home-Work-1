//
//  TestDecode.swift
//  Home Work 1Tests
//
//  Created by Anthony Becker on 12/24/18.
//  Copyright © 2018 Anthony Becker. All rights reserved.
//

import XCTest

@testable import Home_Work_1

class TestDecode: XCTestCase {

    var searchJson: NSData!
    var listJson: NSData!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let testBundle = Bundle(for: type(of: self))

        if let fileURL1 = testBundle.url(forResource: "search", withExtension: "json") {
                if let contents = NSData(contentsOf: fileURL1) {
                    searchJson = contents
                } else {
                    print("Search Json not loaded")
                }
        } else {
            print("Search Json not found")
        }
        
        if let fileURL2 = testBundle.url(forResource: "list", withExtension: "json") {
            if let contents = NSData(contentsOf: fileURL2) {
                listJson = contents
            } else {
                print("List Json not loaded")
            }
        } else {
            print("List Json not found")
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeSearch() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let json = try? JSONSerialization.jsonObject(with: searchJson as Data, options: [])
        if let jsonData = json as? [String:Any] {
            let utTop10API = UTTop10API()
            let list = utTop10API.decode(json:jsonData)
            XCTAssertTrue(list?.items.count == 9,"Count should be 9") // skipped channel
        } else {
            XCTAssertTrue(false, "Search json not decoded")
        }
    }
    
    func testDecodeList() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let json = try? JSONSerialization.jsonObject(with: listJson as Data, options: [])
        if let jsonData = json as? [String:Any] {
            let utTop10API = UTTop10API()
            let list = utTop10API.decode(json:jsonData)
            XCTAssertTrue(list?.items.count == 10,"Count should be 10")
        } else {
            XCTAssertTrue(false, "Search json not decoded")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let json = try? JSONSerialization.jsonObject(with: searchJson as Data, options: [])
            let utTop10API = UTTop10API()
            _ = utTop10API.decode(json:json as! [String:Any] )
        }
    }

}
