//
//  BarrowerFlow.swift
//  WhiteMOney
//
//  Created by Venkatesh on 02/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class BarrowerFlow: NSObject {
    var navigator : Navigator!
    
    init(_ window : UIWindow) {
//        window.rootViewController = AuthPageViewController.instanciateFrom(storyboard: Storyboards.authFlow)
        if let rootNav = window.rootViewController as? UINavigationController{

            navigator = Navigator.init(rootVC: rootNav, sideMenu: nil)
            let authFlow = AuthFlow.init(navigator)
        }
    }
}
