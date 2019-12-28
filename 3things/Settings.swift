//
//  Settings.swift
//  3things
//
//  Created by Sean Mc Mains on 12/27/19.
//  Copyright © 2019 Sean McMains. All rights reserved.
//

import SwiftUI
import Combine

class Settings: ObservableObject {
    // we will only pay attention to the time components of this date
    @Published var reminderTime: Date
    
    init() {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        reminderTime = Calendar.current.date(from: components) ?? Date()
    }
}
