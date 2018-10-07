//
//  BaseViewController.swift
//  Inheridenc_VC
//
//  Created by Venkatesh on 21/09/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController {

    @IBOutlet weak var networkBannerLbl: UILabel?
    @IBOutlet weak var bannerTop: NSLayoutConstraint?
    var didConnectionIsOpen : (_ isConnected : Bool)->Void  = {_ in} {
        didSet{
            didConnectionIsOpen(!(NetworkManager.shared.currentStatus == .notReachable || NetworkManager.shared.currentStatus == .unknown))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func showBanner() -> Void {
        self.networkBannerLbl?.backgroundColor = UIColor.red
        self.bannerTop?.constant = 0.0

    }
    func hideBanner() -> Void {
        self.networkBannerLbl?.backgroundColor = UIColor.green
        self.bannerTop?.constant = -30.0

    }
    var observer : NSObjectProtocol?
    override func viewWillAppear(_ animated: Bool) {
        
        if NetworkManager.shared.currentStatus == .notReachable || NetworkManager.shared.currentStatus == .unknown{
            showBanner()
        }else{
            hideBanner()
        }
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "NetworkStatusGotChanged"), object: nil, queue: nil, using: { (notification) in
           
            if let status = notification.object as? NetworkReachabilityManager.NetworkReachabilityStatus{
                switch status {
                case .notReachable:
                    self.showBanner()
                    self.didConnectionIsOpen(false)
                case .unknown :
                    self.showBanner()
                    self.didConnectionIsOpen(false)
                case .reachable(.ethernetOrWiFi):
                    self.hideBanner()
                    self.didConnectionIsOpen(true)
                case .reachable(.wwan):
                    self.hideBanner()
                    self.didConnectionIsOpen(true)
                }
            }
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
//        self.didConnectionIsOpen = {_ in}
        NotificationCenter.default.removeObserver(observer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
