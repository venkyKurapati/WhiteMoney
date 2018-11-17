//
//  AuthViewController.swift
//  DesignWithAnchors
//
//  Created by Venkatesh on 05/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class Barrower_AuthViewController: UIViewController {
    var didLoad : (UIViewController)->Void = {_ in}
    
    @IBOutlet weak var backgroundThemeView: UIView!
    @IBOutlet weak var stepsItemsView: FormStepsView!
    @IBOutlet weak var fieldsContentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad(self)
        fieldsContentView.applyDropShaddow(UIColor.lightGray)
        backgroundThemeView.backgroundColor =  UIColor.primaryBrandingColor()
        stepsItemsView.items = [" Profile Verification  ","  Eligibility Check   ","   Upload Documents    "]
//        self.view.backgroundColor = UIColor.primaryBrandingColor()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        var leftitem = self.navigationItem.backBarButtonItem
        leftitem?.title = "Back"

        // Do any additional setup after loading the view.
    }
    func onDidLoad(callback: @escaping (UIViewController)->Void) {
        didLoad = callback
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}