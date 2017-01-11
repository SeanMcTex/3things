//
//  TodayViewController.swift
//  3things Today
//
//  Created by Sean Mc Mains on 1/6/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, GoalsManagerDelegate {
    
    @IBOutlet weak var goal1Label: UILabel!
    @IBOutlet weak var goal2Label: UILabel!
    @IBOutlet weak var goal3Label: UILabel!
    
    private let goalsManager = GoalsManager(domain: standardDomain)
    private var completionHandler: ((NCUpdateResult) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.goalsManager.delegate = self
        self.goalsManager.fetchGoals()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: @escaping ((NCUpdateResult) -> Void)) {
        self.completionHandler = completionHandler
        self.goalsManager.fetchGoals()
    }
    
    // MARK:- Delegate Functions
    func didReceive(goals: [Goal]) {
        var newData = false
        for ( label, goal ) in zip( self.labelArray(), goals ) {
            if ( label.text != goal ) {
                label.text = goal
                newData = true
            }
        }
        
        self.completionHandler?( newData ? NCUpdateResult.newData : NCUpdateResult.noData )
    }
    
    // MARK:- Helper Functions
    func labelArray() -> [UILabel] {
        return [goal1Label, goal2Label, goal3Label]
    }
    
}
