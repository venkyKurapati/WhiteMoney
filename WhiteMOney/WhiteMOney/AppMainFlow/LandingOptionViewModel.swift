//
//  LandingOptionViewModel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 04/11/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class LandingOptionViewModel: NSObject {

    var optionsVC : LandingOptionsView!
    var navigator : Navigator!
    
    
    init(_ navi : Navigator) {
        optionsVC = LandingOptionsView.instanciateFrom(storyboard: Storyboards.main)
        navigator = navi
        
        super.init()
    }
    func run() -> Void {
        navigator.rootContentNavigator.viewControllers = [optionsVC]
        optionsVC.didTappedOnBarrow {
            
        }
        optionsVC.didTappedOnLend {
            
        }
        optionsVC.didTappedOnLogin {
            
        }
    }
    
}
