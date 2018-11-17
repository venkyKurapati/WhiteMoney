//
//  LandingOptionsView.swift
//  WhiteMOney
//
//  Created by Venkatesh on 04/11/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class LandingOptionsView: UIViewController {

    @IBOutlet weak var borrowMoneyView: UIView!
    @IBOutlet weak var lendMoneyView: UIView!
    @IBOutlet weak var loginBtn: UIBarButtonItem!
    
    var didTappedOnBarrow : () -> Void = {}
    var didTappedOnLend : () -> Void = {}
    var didTappedOnLogin : () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.view.backgroundColor = UIColor.primaryBrandingColor()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    func updateUI() -> Void {
    
        borrowMoneyView.applyDropShaddow(UIColor.primaryBrandingColor())
        lendMoneyView.applyDropShaddow(UIColor.primaryBrandingColor())
        loginBtn.tintColor = UIColor.primaryBrandingColor()
        
    }
    func didTappedOnLogin(_ callback :@escaping () -> Void ) -> Void {
        self.didTappedOnLogin = callback
    }
    func didTappedOnBarrow(_ callback :@escaping  () -> Void ) -> Void {
        self.didTappedOnBarrow = callback

    }
    func didTappedOnLend(_ callback :@escaping  () -> Void ) -> Void {
        self.didTappedOnLend = callback
    }
    

    @IBAction func loginBtnTapped(_ sender: Any) {
        self.didTappedOnLogin()
    }
    @IBAction func borrowTapped(_ sender: Any) {
        self.didTappedOnBarrow()

    }
    @IBAction func lendTapped(_ sender: Any) {
        self.didTappedOnLend()
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
