//
//  GoalsManagerTests.swift
//  3things
//
//  Created by Sean Mc Mains on 1/5/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import XCTest

private let testDomain = "TestDomain"

class GoalsManagerTests: XCTestCase, GoalsManagerDelegate {
    
    private var sut: GoalsManager?
    private var asyncExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        
        let sut = GoalsManager(domain: testDomain)
        sut.delegate = self
        
        self.sut = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStorage() {
        sut!.store( goals: self.sampleGoals() )
    }
    
    func testRetrieval() {
        self.asyncExpectation = self.expectation(description: "Should return stored values")
        
        sut!.store(goals: self.sampleGoals() )
        sut!.fetchGoals()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testRetrievalFromSecondInstance() {
        self.asyncExpectation = self.expectation(description: "Second instance should return values stored by first instance")
        
        sut!.store(goals: self.sampleGoals() )
        
        let sut2 = GoalsManager( domain: testDomain )
        sut2.delegate = self
        sut2.fetchGoals()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

    // MARK: - Delegate Functions
    
    func didReceive(goals: [Goal]) {
        if goals == self.sampleGoals() {
            self.asyncExpectation?.fulfill()
        }
    }
    
    // MARK: - Helper Functions
    
    func sampleGoals() -> [Goal] {
        let goal1 = Goal(completed: false, name: "Do things")
        let goal2 = Goal(completed: true, name: "Do other things")
        let goal3 = Goal(completed: false, name: "Do a third thing")
        
        let test = goal1 == goal2
        
        return [goal1, goal2, goal3]
    }
    

    
}
