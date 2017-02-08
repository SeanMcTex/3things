//
//  SharingManager.swift
//  3things
//
//  Created by Sean Mc Mains on 2/8/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import Foundation

struct SharingManager {
    func share( goals: [Goal], in container: UIViewController ) {
        let shareText = goalsTitle() + goalsText( goals: goals )
        let activityViewContoller = UIActivityViewController.init(activityItems: [shareText],
                                                                  applicationActivities: nil)
        container.present( activityViewContoller, animated: true, completion: nil)
    }
    
    func goalsTitle() -> String {
        let formatter = configuredDateFormatter()
        let today = Date()
        let dateString = formatter.string(from: today )
        
        let titleString = NSLocalizedString("Goals for %@:\n", comment: "Sharing title")
        return String(format: titleString, dateString)
    }
    
    func configuredDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    func goalsText( goals: [Goal] ) -> String {
        var returnString = ""
        for ( index, goal ) in goals.enumerated() {
            let done = NSLocalizedString("Done", comment: "Share Text Completed")
            let inProgress = NSLocalizedString("In Progress", comment: "Share Text In Progress")
            let completed = goal.completed ? done : inProgress
            let thisItem = "\(index + 1). \(goal.name) [\(completed)]\n"
            returnString += thisItem
        }
        return returnString
    }
}
