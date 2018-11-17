//
//  AppMainFlow.swift
//  WhiteMOney
//
//  Created by Venkatesh on 17/11/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit
import Async
class AppMainFlow: NSObject {
    var navigator : Navigator!
    var token : String? = nil
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
            let loaderVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LaunchLoadingView")
            navigator.windowNavigator.viewControllers = [loaderVc]
            
            
            if token == nil{ // run Auth
                Async.main(after: 1.2, {
                    
                    let landingOptionViewModel = LandingOptionViewModel.init(self.navigator)
                    landingOptionViewModel.run()
                    
                })
                
            }
            
            
            
     
            
            
        }
        
    }
}
