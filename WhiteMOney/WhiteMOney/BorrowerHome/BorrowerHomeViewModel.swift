//
//  BorrowerHomeViewModel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 04/11/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class BorrowerHomeViewModel: NSObject {
    
    var navigator : Navigator!
    var homeVc : BorrowerHomeView!
    init(_ navigator : Navigator) {
        self.navigator = navigator
        self.homeVc = BorrowerHomeView.instanciateFrom(storyboard: Storyboards.borrowerHome)
    }
    func run(){
        self.navigator.setAsRoot(self.homeVc)
    }

}
