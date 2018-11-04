//
//  BorrowerFlow.swift
//  WhiteMOney
//
//  Created by Venkatesh on 02/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit
import Async

class BorrowerFlow: NSObject {
    var navigator : Navigator!
    
    init(_ window : UIWindow) {
//        window.rootViewController = AuthPageViewController.instanciateFrom(storyboard: Storyboards.authFlow)
        super.init()

        if let rootNav = window.rootViewController as? UINavigationController{

            let containerVC = RootVC()
            containerVC.view.backgroundColor = UIColor.red
            if let navVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContentNavigator") as? UINavigationController{
                let sideMenu = SideMenuFeature(on: containerVC, with: navVC)
                navigator = Navigator.init(rootNavigator: rootNav, contentNavigator: navVC, sideMenu: sideMenu)
               

            }
            let authFlow = AuthFlow.init(navigator)
            let loaderVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LaunchLoadingView")
            //navigator.windowNavigator.viewControllers = [loaderVc]


            Async.main(after: 1.2, {
                  // authFlow.runAuthFlow()
            })


        }

    }
}
