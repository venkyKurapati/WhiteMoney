//
//  UIDevice.swift
//  whitemoney2
//
//  Created by Venkatesh on 11/10/18.
//  Copyright © 2018 Leandro Linardos. All rights reserved.
//

import UIKit

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        var identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
//        if identifier == "x86_64" {
//            identifier = "iPad"
//        }
        return identifier
    }
}
