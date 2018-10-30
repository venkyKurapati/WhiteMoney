

//
//  ViewController.swift
//  WhiteMOney
//
//  Created by Venkatesh on 28/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{

    func showCustomToast(message: String, duration: Double = 2) {
        
        var style = ToastStyle()
        style.messageFont = UIFont.appTextFont()
        style.messageColor = UIColor.white
        style.messageAlignment = .center
        style.backgroundColor = UIColor.gray
        self.view.makeToast(message, duration: duration, position: .bottom, style: style)
    }
    func showNotesToast(message: String) {
        showCustomToast(message: message, duration: 1.0)
    }
}
