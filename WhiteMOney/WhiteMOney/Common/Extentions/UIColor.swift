//
//  UIColor.swift
//  WhiteMoney Support
//
//  Created by bogdan on 2018-04-05.
//  Copyright © 2018 WhiteMoney, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class var appYellow: UIColor { get { return UIColor(red:244.0/255, green:228.0/255, blue:63.0/255, alpha:1.0) } }
    class var appDarkBlue: UIColor { get { return UIColor(red:44.0/255, green:72.0/255, blue:114.0/255, alpha:1.0) } }
    class var appGreen: UIColor { get { return UIColor(red:46.0/255, green:204.0/255, blue:113.0/255, alpha:1.0) } }
    class var appRed: UIColor { get { return UIColor(red:214.0/255, green:69.0/255, blue:65.0/255, alpha:1.0) } }
    
    class var WhiteMoney_lightBlue: UIColor {
        get {
            return UIColor(red: 35/255, green: 204/255, blue: 252/255, alpha: 1.0) /* #23ccfc */
        }
    }
    
    class var WhiteMoney_darkBlue: UIColor {
        get {
            return UIColor(red: 20/255, green: 18/255, blue: 31/255, alpha: 1.0) /* #14121f */
        }
    }
    
    class var WhiteMoney_lightGray: UIColor {
        get {
            return UIColor(red: 202/255, green: 208/255, blue: 214/255, alpha: 1.0) /* #cad0d6 */
        }
    }
    
    class var WhiteMoney_gray: UIColor {
        get {
            return UIColor(red: 100/255, green: 111/255, blue: 126/255, alpha: 1.0) /* #646f7e */
        }
    }
    
    class var WhiteMoney_lightBlack: UIColor {
        get {
            return UIColor(red: 46/255, green: 54/255, blue: 65/255, alpha: 1.0) /* #2e3641 */
        }
    }
}
public extension UIColor {
    
    static func hexStringToUIColor (hex: String, alpha: CGFloat? = 1.0) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha!)
        )
    }
    static func appNavBarBgColor() -> UIColor {
        //        return UIColor.hexStringToUIColor(hex: "#1B4298")
        return UIColor.white
    }
    static func appTextGreyColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#A5B3BA")
    }
    
    
    class func appBackgroundColor() -> UIColor{
        return UIColor.hexStringToUIColor(hex: "#ffffff")
    }
    static func tblViewBackgroundColor() -> UIColor{
        return UIColor.hexStringToUIColor(hex: "#f2f2f2")
    }
  
    
    static func appSecondaryTextColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#000000", alpha: 0.54)
    }
    
    static func disabledTextColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#000000", alpha: 0.38)
    }
    static func placeHolderTxtColor() -> UIColor{
        return UIColor.white.withAlphaComponent(0.9)
    }
    static func appRedColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#FFD600")
    }
 
    
    
    static func appContentDeviderColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#C8C7CC")
    }
    
    static func appCaptionColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#8A8A8F")
    }
    static func uploadBackgroundColor() -> UIColor {
        return UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
    }
    
//    static func appBlueColor() -> UIColor {
//        return UIColor.hexStringToUIColor(hex: "#009FF9")
//    }
    
    
    static func primaryBrandingColor() -> UIColor{
        return UIColor.hexStringToUIColor(hex: "#0086F7")
    }
    static func secondaryBrandingColor() -> UIColor{
        return UIColor.white
    }
    
    static func fieldBackgroundColor() -> UIColor{
        return UIColor.hexStringToUIColor(hex: "#0086F7",alpha: 0.6)
    }
    static func appPrimaryTextColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#0086F7",alpha: 0.8)
    }
    class func appHilightedTxtColor() -> UIColor{
        return UIColor.hexStringToUIColor(hex: "#0086F7",alpha: 0.8)
    }

    
    
    
    static func appdropDownBlueColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#1B4298", alpha: 0.7)
    }
    
    static func appThickBlue() -> UIColor{
        return UIColor.hexStringToUIColor(hex: "#008FFF")
    }
    static func appWhiteColor() -> UIColor {
        return UIColor.white
    }
    static func appScreenBgColor() -> UIColor {
        return UIColor.white
    }
    
    
    static func filterViewBgColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.9)
    }
    
    static func filterTableViewBgColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.5)
    }
    
    static func statusBgGreenColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#5DB85B")
    }
    
    static func statusBgRedColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: "#92040F")
    }
    
    static func cellSelectionColor() -> UIColor {
        //        return UIColor.hexStringToUIColor(hex: "#D9F9DF")
        return UIColor.white
    }
}
