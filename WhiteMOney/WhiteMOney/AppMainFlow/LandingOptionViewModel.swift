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
        navigator.windowNavigator.setViewControllers([optionsVC], animated: true)
        optionsVC.didTappedOnBarrow {
            let barrowerAuthFlow = Barrower_AuthFlow.init(self.navigator)
            barrowerAuthFlow.runAuthFlow()
        }
        optionsVC.didTappedOnLend {
            
        }
        optionsVC.didTappedOnLogin {
            
        }
    }
    
}
