//
//  ViewController.swift
//  WhiteMOney
//
//  Created by Venkatesh on 30/09/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stepsView: FormStepsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsView.items = ["Step-1","Step-2","Step-3","Step-4"]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func s1(_ sender: Any) {
        stepsView.chaangeStepTo(1)
    }
    @IBAction func s2(_ sender: Any) {
        stepsView.chaangeStepTo(2)
    }
    @IBAction func s3(_ sender: Any) {
        stepsView.chaangeStepTo(3)
    }
    
}

