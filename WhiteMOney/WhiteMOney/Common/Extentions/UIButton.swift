//
//  UIButton.swift
//  WhiteMoney Support
//
//  Created by bogdan on 2018-04-05.
//  Copyright © 2018 WhiteMoney, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func applySimpleBorderStyle() {
        applyStyle(color: Color.lightBlue(), textColor: Color.lightBlue(), fill: UIColor.white)
    }
    
    func applySimpleOtherBorderStyle() {
        applyStyle(color: Color.lightBlue(), textColor: Color.lightBlue(), fill: UIColor.white)
    }
    
    func applySimpleBorderDestructiveStyle() {
        applyStyle(color: UIColor.primaryBrandingColor(), textColor: UIColor.primaryBrandingColor(), fill: UIColor.white)
    }
    
    func applyRoundedButtonStyle() {
        applyStyle(color: Color.lightBlue(), textColor: UIColor.white, fill: Color.lightBlue())
    }
    
    func applyRoundedOtherButtonStyle() {
        applyStyle(color: Color.lightBlue(), textColor: UIColor.white, fill: Color.lightBlue())
    }
    
    func applyRoundedDestructiveButtonStyle() {
        applyStyle(color: Color.lightBlue(), textColor: Color.lightBlue(), fill: UIColor.white)
    }
    
    func applyStyle(color: UIColor, textColor: UIColor, fill: UIColor) {
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = color.cgColor;
        self.tintColor = color;
        self.backgroundColor = fill
        self.titleLabel?.font = UIFont.appSemiboldFont(ofSize: self.titleLabel?.font?.pointSize ?? 15)
        self.setTitleColor(textColor, for: .normal)
        self.setTitleColor(textColor.withAlphaComponent(0.5), for: .highlighted)
        self.setTitleColor(textColor.withAlphaComponent(0.5), for: .disabled)
    }
    func isEnabled(_ bool : Bool) -> Void {
        if bool {
            self.alpha = 1
            self.isUserInteractionEnabled = true
        }else{
            self.alpha = 0.6
            self.isUserInteractionEnabled = false

        }
    }

}

