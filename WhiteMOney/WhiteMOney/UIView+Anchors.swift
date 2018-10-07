//
//  UIView+Anchors.swift
//  DesignWithAnchors
//
//  Created by Venkatesh on 18/12/17.
//  Copyright © 2017 Venkatesh. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
   
    func setTopAnc(_ toAnchor : NSLayoutYAxisAnchor , withConst : CGFloat) -> NSLayoutConstraint {
        
        let topAncho = self.topAnchor.constraint(equalTo: toAnchor , constant: withConst)
        topAncho.isActive = true
        return topAncho
    }
    func setBottomAnc(_ toAnchor : NSLayoutYAxisAnchor , withConst : CGFloat) -> NSLayoutConstraint {
        let bottomAncho = self.bottomAnchor.constraint(equalTo: toAnchor , constant: -withConst)
        bottomAncho.isActive = true
        return bottomAncho
    }
    func setLeadingAnc(_ toAnchor : NSLayoutXAxisAnchor , withConst : CGFloat) -> NSLayoutConstraint {
        
        let leadingAncho = self.leadingAnchor.constraint(equalTo: toAnchor , constant: withConst)
        leadingAncho.isActive = true
        return leadingAncho
        
    }
    func setTrailingAnc(_ toAnchor : NSLayoutXAxisAnchor , withConst : CGFloat) -> NSLayoutConstraint {
        
        let trailingAncho = self.trailingAnchor.constraint(equalTo: toAnchor , constant: -withConst)
        trailingAncho.isActive = true
        return trailingAncho
    }
    
    func setWidthEqualTo(_ toAnchor : NSLayoutDimension  , withMultiplier : CGFloat) -> NSLayoutConstraint {
       let widthAnc = self.widthAnchor.constraint(equalTo: toAnchor, multiplier: withMultiplier)
        widthAnc.isActive = true
        return widthAnc
    }
    
    func setHeightEqualTo(_ toAnchor : NSLayoutDimension , withMultiplier : CGFloat) -> NSLayoutConstraint {
        let heightAnc = self.heightAnchor.constraint(equalTo: toAnchor, multiplier: withMultiplier)
        heightAnc.isActive = true
        return heightAnc
    }

    func setCenterHorizantalTo(_ toView : UIView , withConst : CGFloat) -> NSLayoutConstraint {
        let centerXanc =  self.centerXAnchor.constraint(equalTo: toView.centerXAnchor, constant: withConst)
        centerXanc.isActive = true
        return centerXanc
    }
    
    func setCenterVerticalTo(_ toView : UIView , withConst : CGFloat) -> NSLayoutConstraint {
        let centerYanc = self.centerYAnchor.constraint(equalTo: toView.centerYAnchor, constant: withConst)
        centerYanc.isActive = true
        return centerYanc
    }
    
    
}
