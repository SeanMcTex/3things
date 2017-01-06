//
//  ViewController.swift
//  3things
//
//  Created by Sean Mc Mains on 1/5/17.
//  Copyright © 2017 Sean McMains. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var goal1Field: UITextField!
    @IBOutlet weak var goal2Field: UITextField!
    @IBOutlet weak var goal3Field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPushSetGoalsButton(_ sender: AnyObject) {
    }

}

