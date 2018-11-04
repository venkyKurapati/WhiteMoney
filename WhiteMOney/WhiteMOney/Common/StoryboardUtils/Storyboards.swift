//
//  Storyboards.swift
//  WhiteMoney2
//
//  Created by Leandro Linardos on 06/04/2018.
//  Copyright © 2018 Leandro Linardos. All rights reserved.
//

import Foundation

public enum Storyboards: String {
    case main
    case authFlow
    case borrowerHome
}

extension Storyboards : Storyboard {
    var filename: String {
        switch self {
        default: return String(rawValue.prefix(1)).uppercased() + String(rawValue.dropFirst())
        }
    }
}
