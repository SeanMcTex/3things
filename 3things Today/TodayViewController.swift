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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.goalsManager.delegate = self
        self.goalsManager.fetchGoals()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    // MARK:- Delegate Functions
    func didReceive(goals: [Goal]) {
        for ( label, goal ) in zip( self.labelArray(), goals ) {
            label.text = goal
        }
    }
    
    // MARK:- Helper Functions
    func labelArray() -> [UILabel] {
        return [goal1Label, goal2Label, goal3Label]
    }
    
}
