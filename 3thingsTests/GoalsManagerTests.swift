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
    private var asyncCompletion: (( _ goals: [Goal], _ areGoalsCurrent: Bool ) -> (Void))?
    
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
        self.asyncCompletion = { ( goals, date ) in
            if goals == self.sampleGoals() {
                self.asyncExpectation?.fulfill()
            }
        }
        
        sut!.store(goals: self.sampleGoals() )
        sut!.fetchGoalsAndTimestamp()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testRetrievalFromSecondInstance() {
        self.asyncExpectation = self.expectation(
            description: "Second instance should return values stored by first instance")
        self.asyncCompletion = { ( goals, date ) in
            if goals == self.sampleGoals() {
                self.asyncExpectation?.fulfill()
            }
        }
        
        sut!.store(goals: self.sampleGoals() )
        
        let sut2 = GoalsManager( domain: testDomain )
        sut2.delegate = self
        sut2.fetchGoalsAndTimestamp()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatTodaysGoalsAreCurrent() {
        self.asyncExpectation = self.expectation(description: "Should return stored values")
        self.asyncCompletion = { ( goals, areGoalsCurrent ) in
            if areGoalsCurrent {
                self.asyncExpectation?.fulfill()
            }
        }
        
        sut!.store(goals: self.sampleGoals(), timestamp: Date() )
        sut!.fetchGoalsAndTimestamp()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatYesterdaysGoalsAreNotCurrent() {
        self.asyncExpectation = self.expectation(description: "Should return stored values")
        self.asyncCompletion = { ( goals, areGoalsCurrent ) in
            if !areGoalsCurrent {
                self.asyncExpectation?.fulfill()
            }
        }
        
        let yesterday = Date().addingTimeInterval( -86400.0 )
        sut!.store(goals: self.sampleGoals(), timestamp: yesterday )
        sut!.fetchGoalsAndTimestamp()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatSavingWithoutTimestampDoesntMakeGoalsCurrent() {
        self.asyncExpectation = self.expectation(description: "Should return stored values")
        self.asyncCompletion = { ( goals, areGoalsCurrent ) in
            if !areGoalsCurrent {
                self.asyncExpectation?.fulfill()
            }
        }
        
        let yesterday = Date().addingTimeInterval( -86400.0 )
    
        sut!.store(goals: self.sampleGoals(), timestamp: yesterday )
        sut!.store(goals: self.sampleGoals(), timestamp: nil )
    
        sut!.fetchGoalsAndTimestamp()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)

    }
    
    // MARK: - Delegate Functions
    
    func didReceive(goals: [Goal], areGoalsCurrent: Bool) {
        self.asyncCompletion?(goals, areGoalsCurrent)
    }
    
    // MARK: - Helper Functions
    
    func sampleGoals() -> [Goal] {
        let goal1 = Goal(completed: false, name: "Do things")
        let goal2 = Goal(completed: true, name: "Do other things")
        let goal3 = Goal(completed: false, name: "Do a third thing")
        
        return [goal1, goal2, goal3]
    }
    
}
