//
//  ViewController.swift
//  NavTest
//
//  Created by Venkatesh on 23/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func add(_ sender: Any) {
        
      //  let navVc = self.storyboard?.instantiateViewController(withIdentifier: "Nav1")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "V2")
        let navVc = UINavigationController()
        navVc.viewControllers = [vc] as! [UIViewController]
        self.present(navVc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

