//
//  Goal.swift
//  3things
//
//  Created by Sean Mc Mains on 1/15/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

struct Goal: Equatable, PropertyListReadable {
    var completed: Bool = false
    var name: String = ""
}

func == (lhs: Goal, rhs: Goal) -> Bool {
    return rhs.completed == lhs.completed && rhs.name == lhs.name
}

// I'd prefer to have this extension in PropertyListReadable.swift, but
// the compiler segfaults when I do so. Yay.
extension Goal {
    static let completedKey = "completedKey"
    static let nameKey = "nameKey"
    
    init(propertyListRepresentation: NSDictionary) {
        let completed = propertyListRepresentation[Goal.completedKey] as? Bool
        let name = propertyListRepresentation[Goal.nameKey] as? String
        
        self.completed = completed ?? false
        self.name = name ?? ""
    }
    
    func propertyListRepresentation() -> NSDictionary {
        let dictionary: [String: Any] = [ Goal.completedKey: self.completed,
                                           Goal.nameKey: self.name]
        return dictionary as NSDictionary
    }
    
}
