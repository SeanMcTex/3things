//
//  ViewController.swift
//  3things
//
//  Created by Sean Mc Mains on 1/5/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, GoalsManagerDelegate {

    public var goalsManager: GoalsManager?
    
    @IBOutlet weak var goal1Field: UITextField!
    @IBOutlet weak var goal2Field: UITextField!
    @IBOutlet weak var goal3Field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.goalsManager = GoalsManager(domain: standardDomain)
        self.goalsManager?.delegate = self
        self.goalsManager?.fetchGoals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPushSetGoalsButton(_ sender: AnyObject) {
        let goals = self.goalFields().map{ $0.text ?? "" }
        self.goalsManager?.store(goals: goals)
    }
    
    // MARK:- Delegate Methods
    func didReceive(goals: [Goal]) {
        for ( field, goal ) in zip( self.goalFields(), goals ) {
            field.text = goal
        }
    }
    
    // MARK:- Helper Methods
    func goalFields() -> [UITextField] {
        return [goal1Field, goal2Field, goal3Field]
    }

}

