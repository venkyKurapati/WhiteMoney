//
//  SideMenuFlow.swift
//  whitemoney
//
//  Created by Exequiel Banga on 21/11/16.
//  Copyright © 2016 codika. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class SideMenuFlow: NSObject {
    
    private var storyboard : UIStoryboard!
    var navigator: Navigator!
    
    fileprivate var options: [SideMenuOption] = []
    func set(options: [SideMenuOption]) { self.options = options }
    
    var sideMenuFeature: SideMenuFeature!
    
    func setup () {
        storyboard = UIStoryboard(name: "Root" , bundle: Bundle.main)
        
        // Put in AppFlow - Setup
        options = [
            SideMenuOption("My Account", #imageLiteral(resourceName: "myAccount"), onSelect: {_ in
                self.sideMenuFeature.hide(animated: true)
//                self.myAccountScene.run()
//                self.navigator.presentOverCurrent(vc: self.myAccountVC, onCompletion: nil)
            }),
            SideMenuOption("Manage Users", #imageLiteral(resourceName: "manageUser"), onSelect: {_ in }),
            SideMenuOption("Manage Services", #imageLiteral(resourceName: "manageServices"), onSelect: {_ in }),
            SideMenuOption("Rules", #imageLiteral(resourceName: "rules"), onSelect: {_ in
                self.sideMenuFeature.hide(animated: true)
//                self.makeRulesFlow.navigator = self.navigator
//                self.makeRulesFlow.run()
            }),
            SideMenuOption("Help", #imageLiteral(resourceName: "help"), onSelect: {_ in })
            ,]
        
    }
    
    func selectOptionWithName(_ name: String) {
        options.filter({ $0.name == name }).first?.onSelect?(nil)
    }
}
