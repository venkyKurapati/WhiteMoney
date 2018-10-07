//
//  SideMenuViewController.swift
//  WhiteMoney
//
//  Created by Exequiel Banga on 9/30/16.
//  Copyright © 2016 codika. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    @IBOutlet weak var panToAppearView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var termsOfServiceLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    
    
    @IBOutlet weak var headerView: UIView!
    var onHeaderTap: (()->())?
    private var onWillAppear: (SideMenuViewController)->() = {_ in }
    func onWillAppearDo(_ callback: @escaping (SideMenuViewController)->()) {
        onWillAppear = callback
    }
    
    private var onDidLayout: (SideMenuViewController)->() = {_ in }
    func onDidLayoutDo(_ callback: @escaping (SideMenuViewController)->()) {
        onDidLayout = callback
    }
    
    func show() {
//        let user = User.current
//        
//        profilePic.image = #imageLiteral(resourceName: "defaultProfile")
//        
//        nameLabel.text = (user?.firstName ?? "") + " " + (user?.lastName ?? "")
//        profilePic.set(image: user?.photo ?? .local( #imageLiteral(resourceName: "defaultProfile")), placeholderImage: #imageLiteral(resourceName: "defaultProfile"))
//        emailLabel.text = user?.email ?? ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profilePic.clipsToBounds = true
        profilePic.layer.cornerRadius = profilePic.layer.frame.width/2.0
//        onDidLayout(self)
    }
    
    fileprivate func value(_ string: String, or default: String) -> String {
        return string.isEmpty ? "" : string
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTap)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onWillAppear(self)
    }
    
    @objc func headerTap() {
        onHeaderTap?()
    }
}
