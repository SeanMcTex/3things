//
//  QuotesManagerTests.swift
//  3things
//
//  Created by Sean Mc Mains on 1/27/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import XCTest
@testable import _things

class QuotesManagerTests: XCTestCase {
    
    private var sut: QuotesManager?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.sut = QuotesManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetQuote() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let quote = sut?.randomQuote()
        
        XCTAssertNotNil( quote )
    }
    
}
