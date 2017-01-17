//
//  GoalsManager.swift
//  3things
//
//  Created by Sean Mc Mains on 1/5/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

public let standardDomain = "group.mcmains.net.things"

private let goalsKey = "goalsKey"
private let timestampKey = "timestampKey"
private let oneDayAgo = TimeInterval( -86400 )

protocol GoalsManagerDelegate: class {
    func didReceive(goals: [Goal], areGoalsCurrent: Bool)
}

class GoalsManager {
    public weak var delegate: GoalsManagerDelegate?
    public let domain: String
    
    private var goals: [Goal] = []
    private var timestamp: Date = Date().addingTimeInterval( oneDayAgo )
    private let userDefaults: UserDefaults?
    
    init(domain: String) {
        self.domain = domain
        self.userDefaults = UserDefaults(suiteName: domain)
    }
    
    func store(goals: [Goal], timestamp: Date = Date() ) {
        self.goals = goals
        self.timestamp = timestamp
        
        let propertyListArray = goals.map { $0.propertyListRepresentation() }
        self.userDefaults?.set(propertyListArray, forKey: goalsKey)
        
        self.userDefaults?.set(timestamp, forKey: timestampKey)
        self.userDefaults?.synchronize()
    }
    
    func fetchGoalsAndTimestamp() {
        let goals = fetchGoals()
        let current = areGoalsCurrent()
        
        self.delegate?.didReceive(goals: goals, areGoalsCurrent: current )
    }
    
    private func fetchGoals() -> [Goal] {
        if let goalsPropertyListArray = self.userDefaults?.array(forKey: goalsKey) {
            let goals: [Goal] = goalsPropertyListArray.map {
                if let dictionary = $0 as? NSDictionary {
                    return Goal.init(propertyListRepresentation: dictionary)
                } else {
                    return Goal()
                }
            }
            self.goals = goals
        }
        return self.goals
    }
    
    private func fetchTimestamp() -> Date {
        if let timestamp = self.userDefaults?.object(forKey: timestampKey) as? Date {
            self.timestamp = timestamp
        }
        return self.timestamp
    }
    
    private func areGoalsCurrent() -> Bool {
        let timestamp = self.fetchTimestamp()
        
        return Calendar.current.isDateInToday(timestamp)
    }
    
}
