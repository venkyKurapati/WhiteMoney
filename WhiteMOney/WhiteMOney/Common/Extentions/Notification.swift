//
//  Notification.swift
//  WhiteMoney Support
//
//  Created by bogdan on 2018-04-05.
//  Copyright © 2018 WhiteMoney, Inc. All rights reserved.
//

import Foundation

extension Notification {
    public struct Key {
        public static let remotePush: String = "RemotePush"
    }
}

//extension Notification.Name {
//    static func remotePushPending(type: RemotePushType) -> Notification.Name {
//        let name = Notification.Name("RemotePushPending_\(type.rawValue)")
//        return name
//    }
//}

