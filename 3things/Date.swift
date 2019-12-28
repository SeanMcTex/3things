//
//  Date.swift
//  3things
//
//  Created by Sean Mc Mains on 1/23/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

extension Date {
    func components() -> DateComponents {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self)
    }
    
    static func todayAtTime(hour: Int, minute: Int) -> Date {
        var components = Date().components()
        components.hour = hour
        components.minute = minute
        components.second = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }

    func next( days: Int, includeStartDate: Bool ) -> Set<Date> {
        var returnValues: Set<Date> = []
        
        if includeStartDate {
            returnValues.insert( self )
        }
        
        var workingDate = self
        for _ in 1...days {
            if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: workingDate) {
                returnValues.insert( newDate )
                workingDate = newDate
            }
        }
        return returnValues
    }
}
