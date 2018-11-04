//
//  BarrowerHomeViewModel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 04/11/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class BarrowerHomeViewModel: NSObject {
    
    var navigator : Navigator!
    var homeVc : BarrowerHomeView!
    init(_ navigator : Navigator) {
        self.navigator = navigator
        self.homeVc = BarrowerHomeView.instanciateFrom(storyboard: Storyboards.barrowerHome)
    }
    func run(){
        self.navigator.setAsRoot(self.homeVc)
    }

}
