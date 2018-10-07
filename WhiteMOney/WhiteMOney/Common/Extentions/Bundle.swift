//
//  Bundle.swift
//  WhiteMoney2
//
//  Created by Venkatesh on 31/08/18.
//  Copyright © 2018 Leandro Linardos. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
