//
//  UIFont.swift
//  WhiteMoney Support
//
//  Created by bogdan on 2018-04-05.
//  Copyright © 2018 WhiteMoney, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func appBoldFont(ofSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: ofSize)
    }
    
    class func appRegularFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize)
    }
    
    class func appRegularFontItalic(ofSize: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: ofSize)
    }
    
    class func appMediumFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight:.medium)
    }
    
    class func appSemiboldFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight:.semibold)
    }
    
    class func appSemiboldItalicFont(ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-BoldItalic", size: ofSize) {
            return font
        } else {
            return appRegularFont(ofSize: ofSize)
        }
    }
    
    class func appLightFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight:.light)
    }
    
    class func appLightItalicFont(ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-LightItalic", size: ofSize) {
            return font
        } else {
            return appRegularFont(ofSize: ofSize)
        }
    }

}

extension UIFont {
    
    class func appTitleFont() -> UIFont {
        return UIFont.appMediumFont(ofSize: 16)
    }
    
    class func appCellTextFieldFont() -> UIFont {
        return appRegularFont(ofSize: 16)
    }
    
    class func appTextFont() -> UIFont {
        return UIFont.appRegularFont(ofSize: 14)
    }
    
    class func appSectionTextFont() -> UIFont {
        return UIFont.appMediumFont(ofSize: 14)
    }
    
    class func appSubTextFont() -> UIFont {
        return UIFont.appRegularFont(ofSize: 14)
    }
    
    class func appCaptionFont() -> UIFont {
        return UIFont.appRegularFont(ofSize: 12)

    }
    
    class func appButtonsfont() -> UIFont {
        return UIFont.appMediumFont(ofSize: 14)
    }
    
    class func appStatusFont() -> UIFont {
        return UIFont.appMediumFont(ofSize: 12)

    }
}
