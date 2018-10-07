//
//  NetworkManager.swift
//  WhiteMoney2
//
//  Created by Venkatesh on 21/09/18.
//  Copyright © 2018 Leandro Linardos. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    var currentStatus: NetworkReachabilityManager.NetworkReachabilityStatus = .notReachable
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    func startNetworkReachabilityObserver() {
        
        reachabilityManager?.listener = { status in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NetworkStatusGotChanged"), object: status)
            self.currentStatus = status
            switch status {
            case .notReachable:
                print("The network is not reachable")
            case .unknown :
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
            }
        }
        reachabilityManager?.startListening()
    }
}


