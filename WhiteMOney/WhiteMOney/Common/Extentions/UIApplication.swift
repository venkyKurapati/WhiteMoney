//
//  UIColor.swift
//  WhiteMoney Support
//
//  Created by bogdan on 2018-04-05.
//  Copyright © 2018 WhiteMoney, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    func configureAppAppearance() {
        self.statusBarStyle = .lightContent
        
        let tintColor: UIColor = UIColor.appDarkBlue
        
        for window in self.windows {
            window.tintColor = tintColor
        }
        
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = tintColor
        
        let navigationBar = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.WhiteMoney_darkBlue
        
    }
    
    /*
    func configureAppAppearance() {
        self.statusBarStyle = .lightContent
        
        let tintColor: UIColor = UIColor.appDarkBlue
        
        for window in self.windows {
            window.tintColor = tintColor
        }
        
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = tintColor
        
        let navigationBar = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.appDarkBlue
        navigationBar.tintColor = UIColor.appGreen
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.appRegularFont(ofSize: 16)]

        let barButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        barButtonItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.appRegularFont(ofSize: 14)], for: .normal)
        barButtonItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.appRegularFont(ofSize: 14)], for: .disabled)
        
        let toolbar = UIToolbar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        toolbar.isTranslucent = false
        toolbar.barTintColor = UIColor.lightGray
        toolbar.tintColor = UIColor.appGreen
    }
 */
}

