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

protocol GoalsManagerDelegate: class {
    func didReceive(goals: [Goal])
}

class GoalsManager {
    public weak var delegate: GoalsManagerDelegate?
    public let domain: String
    
    private var goals: [Goal] = []
    private let userDefaults: UserDefaults?
    
    init(domain: String) {
        self.domain = domain
        self.userDefaults = UserDefaults(suiteName: domain)
    }
    
    func store(goals: [Goal]) {
        self.goals = goals
        let propertyListArray = goals.map { $0.propertyListRepresentation() }
        self.userDefaults?.set(propertyListArray, forKey: goalsKey)
        self.userDefaults?.synchronize()
    }
    
    func fetchGoals() {
        if let goalsPropertyListArray = self.userDefaults?.array(forKey: goalsKey) {
            let goals: [Goal] = goalsPropertyListArray.map {
                if let dictionary = $0 as? NSDictionary {
                    return Goal.init(propertyListRepresentation: dictionary)
                } else {
                    return Goal()
                }
            }
            self.delegate?.didReceive(goals: goals)
        } else {
            self.delegate?.didReceive(goals: self.goals)
        }
    }
}
