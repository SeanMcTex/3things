//
//  GoalsManager.swift
//  3things
//
//  Created by Sean Mc Mains on 1/5/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

typealias Goal = String
public let standardDomain = "group.mcmains.net.things"


private let goalsKey = "goalsKey"

protocol GoalsManagerDelegate {
    func didReceive(goals:[Goal])
}

class GoalsManager {
    public var delegate: GoalsManagerDelegate?
    public let domain: String
    
    private var goals: [Goal] = []
    private let userDefaults: UserDefaults?
    
    init(domain: String) {
        self.domain = domain
        self.userDefaults = UserDefaults(suiteName: domain)
    }
    
    func store(goals: [Goal]) {
        self.goals = goals
        self.userDefaults?.set(goals, forKey: goalsKey)
        self.userDefaults?.synchronize()
    }
    
    func fetchGoals() -> Void {
        if let goalsArray = self.userDefaults?.array(forKey: goalsKey),
        let goals = goalsArray as? [Goal] {
            self.delegate?.didReceive(goals: goals)
        } else {
            self.delegate?.didReceive(goals: self.goals)
        }
    }
}
