//
//  ViewController.swift
//  3things
//
//  Created by Sean Mc Mains on 1/5/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, GoalsManagerDelegate, UITextFieldDelegate {
    
    public var goalsManager: GoalsManager?
    
    @IBOutlet weak var goal1Field: UITextField!
    @IBOutlet weak var goal2Field: UITextField!
    @IBOutlet weak var goal3Field: UITextField!
    
    @IBOutlet weak var goal1CheckBox: BEMCheckBox!
    @IBOutlet weak var goal2CheckBox: BEMCheckBox!
    @IBOutlet weak var goal3CheckBox: BEMCheckBox!
    
    @IBOutlet weak var setGoalsButton: UIButton!
    
    private var isEditingActive: Bool  {
        get {
            return self.goal1CheckBox.isHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGoalsManager()
        configureCheckBoxes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPushSetGoalsButton(_ sender: AnyObject) {
        toggleUIState()
        persistGoals()
    }
    
    // MARK:- Delegate Methods
    func didReceive(goals: [Goal]) {
        for ( field, goal ) in zip( self.goalFields(), goals ) {
            field.text = goal
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case goal1Field:
            clearAndActivate(field: goal2Field)
        case goal2Field:
            clearAndActivate(field: goal3Field)
        case goal3Field:
            updateUIToGoalsEnteredState(animated: true)
            persistGoals()
        default:
            break
        }
        return true
    }
    
    // MARK:- Helper Methods
    func goalFields() -> [UITextField] {
        return [goal1Field, goal2Field, goal3Field]
    }
    
    func goalCheckBoxes() -> [BEMCheckBox] {
        return [goal1CheckBox, goal2CheckBox, goal3CheckBox]
    }
    
    func persistGoals() {
        let goals = self.goalFields().map{ $0.text ?? "" }
        self.goalsManager?.store(goals: goals)
    }
    
    func toggleUIState() {
        if isEditingActive {
            updateUIToGoalsEnteredState(animated: true)
        } else {
            updateUIToEditingState(animated: true)
        }
    }
    
    func updateUIToGoalsEnteredState(animated: Bool) {
        var delay = 0.0
        for ( field, checkbox ) in zip ( goalFields(), goalCheckBoxes() ) {
            
            let animations = {
                field.isEnabled = false
                field.resignFirstResponder()
                
                checkbox.isHidden = false
                checkbox.alpha = 1.0
                checkbox.setNeedsDisplay()
            }
            if ( animated ) {
                UIView.animate(withDuration: 0.3, delay: delay, options: UIViewAnimationOptions.curveEaseInOut, animations: animations, completion: nil)
                delay = delay + 0.1
            } else {
                animations()
            }
        }
    }
    
    func updateUIToEditingState(animated: Bool) {
        var delay = 0.0
        for ( field, checkbox ) in zip ( goalFields(), goalCheckBoxes() ) {
            
            let animations = {
                field.isEnabled = true
                
                checkbox.isHidden = true
                checkbox.setNeedsDisplay()
                checkbox.alpha = 0.0
            }
            
            if ( animated ) {
                UIView.animate(withDuration: 0.3, delay: delay, options: UIViewAnimationOptions.curveEaseInOut, animations: animations, completion: nil)
                delay = delay + 0.1
            } else {
                animations()
            }
        }
    }
    
    func clearAndActivate( field: UITextField ) {
        field.text = ""
        field.becomeFirstResponder()
    }
    
    func configureGoalsManager() {
        self.goalsManager = GoalsManager(domain: standardDomain)
        self.goalsManager?.delegate = self
        self.goalsManager?.fetchGoals()
    }
    
    func configureCheckBoxes() {
        for checkbox in goalCheckBoxes() {
            checkbox.onAnimationType = .fill
            checkbox.offAnimationType = .fill
        }
    }
}

