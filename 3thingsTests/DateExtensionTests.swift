//
//  DateExtensionTests.swift
//  3things
//
//  Created by Sean Mc Mains on 1/23/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import XCTest
@testable import _things

class DateExtensionTests: XCTestCase {
    var sut: Date?
    
    override func setUp() {
        super.setUp()
        self.sut = januaryFirst2001()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNext7Days() {
        let dates = self.sut?.next( days: 7, includeStartDate: false )
        
        XCTAssert( dates?.count == 7)
        XCTAssertFalse( dates?.contains( self.sut! ) ?? false )
    }
    
    func testNext7DaysWithStartDate() {
        let dates = self.sut?.next( days: 7, includeStartDate: true )
        
        XCTAssert( dates?.count == 8)
        XCTAssertTrue( dates?.contains( self.sut! ) ?? false )
    }
    
    func januaryFirst2001() -> Date {
        return Date(timeIntervalSinceReferenceDate: 0)
    }
    
}
