//
//  MainFlow.swift
//  truthing
//
//  Created by Exequiel Banga on 9/29/16.
//  Copyright © 2016 codika. All rights reserved.
//

import UIKit

class SideMenuNavigation: NSObject {
    var initialVC: UIViewController!
    var navigator: Navigator!
    private var sideMenuFlow : SideMenuFlow!
    private var sideMenuFeature = SideMenuFeature()
    
    func setup() {
        sideMenuFeature.parentVC = initialVC
        //        sideMenuFeature.panToShowMenuView = mainVC.view
        sideMenuFeature.setup()
        
        sideMenuFlow = SideMenuFlow()
        sideMenuFlow.navigator = navigator
        sideMenuFlow.sideMenuFeature = sideMenuFeature
        
        sideMenuFlow.setup()
    }
    
    @objc private func onSideMenuTap() {
        sideMenuFeature.toogle(animated: true)
    }
    
    func run() {
        navigator.sideMenu = sideMenuFlow.sideMenuFeature
        navigator.setAsRoot(initialVC)
    }
}
