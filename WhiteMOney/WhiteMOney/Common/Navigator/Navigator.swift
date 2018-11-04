//
//  Navigator.swift
//  whitemoney
//
//  Created by Exequiel Banga on 10/3/16.
//  Copyright © 2016 codika. All rights reserved.
//

import UIKit

class BaseNavigator: NSObject {
  
    func push<T: UIViewController>(_ vc: T, animated: Bool = true, callback: @escaping (T)->Void = {_ in }) {}
    func pushReplacingCurrent<T: UIViewController>(_ vc: T, callback: @escaping (T)->Void = {_ in }) {}
    func nativeModal(vc: UIViewController, callback: @escaping ()->Void = {}) {}
    func nativeModalDismiss(_ callback: @escaping ()->() = {}) {}
    func pop() {}
}

class Navigator: BaseNavigator {
    let sideMenu: SideMenuFeature?
    private(set) var rootContentNavigator: UINavigationController
    var vcsPresentedOver = [UIViewController]()
    private var animationDuration: TimeInterval = 0.3
    
    
    private var appearFading = AppearFading()
    var windowNavigator : UINavigationController
    
    init(rootNavigator: UINavigationController,contentNavigator: UINavigationController, sideMenu: SideMenuFeature?) {
        self.sideMenu = sideMenu
        self.windowNavigator = rootNavigator
        self.rootContentNavigator = contentNavigator
        self.windowNavigator.setNavigationBarHidden(false, animated: true)
        rootContentNavigator.setNavigationBarHidden(true, animated: false)
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfileInfoSideMenu), name: NSNotification.Name(rawValue: "UpdateProfileInfoInSideMenu"), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setAsRoot(_ vc: UIViewController) {
        if !UIDevice().modelName.contains("iPad"){
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "HamburgerIcon_.png.png"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(onShowMenu))
            
        }
        
        vc.title = "White Money"
        vc.navigationController?.navigationBar.tintColor = UIColor.WhiteMoney_darkBlue
        self.rootContentNavigator.setNavigationBarHidden(false, animated: true)
        self.windowNavigator.setNavigationBarHidden(true, animated: true)
        self.rootContentNavigator.setViewControllers([vc], animated: true)
        if let parentVC = sideMenu?.parentVC{
            self.windowNavigator.setViewControllers([parentVC], animated: true)
        }
    }
    func isContainVCInContentNavigator(stringVC : String) -> (Bool,Int?) {
        for (i,vc) in rootContentNavigator.viewControllers.enumerated() {
            if NSStringFromClass(type(of: vc)).hasSuffix(stringVC) {
                return (true,i)
            }
        }
        return (false,nil)

    }
    
    func restart(with vc: UIViewController) {
//        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "root_hamburger"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(onShowMenu))
//        vc.navigationItem.title = "whitemoney"
        if (vcsPresentedOver.count != 0) {
            self.unpresentOverPresentedVC(animated: false) {
                
            }
        }
        
        self.rootContentNavigator.setNavigationBarHidden(true, animated: true)
        self.rootContentNavigator.setViewControllers([vc], animated: false)
    }
    
    @objc func onShowMenu() {
        sideMenu?.toogle(animated: true)
    }
    @objc func updateProfileInfoSideMenu(){
        
        sideMenu?.sideMenuController.show()
    }
    
    override func push<T: UIViewController>(_ vc: T, animated: Bool = true, callback: @escaping (T)->Void = { _ in }) {
        let navVC = rootContentNavigator.presentedViewController as? UINavigationController ?? rootContentNavigator
        WillAppearDelegate(vc: vc, callback: { vc in
            callback(vc as! T)
        }).assign(to: navVC)
        
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navVC.topViewController?.navigationItem.backBarButtonItem = item
        navVC.pushViewController(vc, animated: animated)
    }
    
    override func pop() {
        let navVC = rootContentNavigator.presentedViewController as? UINavigationController ?? rootContentNavigator
        navVC.popViewController(animated: true)
    }
    
    override func pushReplacingCurrent<T: UIViewController>(_ vc: T, callback: @escaping (T)->Void) {
        WillAppearDelegate(vc: vc, callback: { vc in
            callback(vc as! T)
        }).assign(to: self.rootContentNavigator)
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.rootContentNavigator.topViewController?.navigationItem.backBarButtonItem = item
        var vcs = self.rootContentNavigator.viewControllers
        vcs.removeLast()
        vcs.append(vc)
        self.rootContentNavigator.setViewControllers(vcs, animated: true)
    }
    
    func popToRoot(callback: @escaping ()->Void = {}) {
        WillAppearDelegate(vc: self.rootContentNavigator.viewControllers.first!, callback: { vc in
            callback()
        }).assign(to: self.rootContentNavigator)
        self.rootContentNavigator.popToRootViewController(animated: true)
    }
    
    override func nativeModal(vc: UIViewController, callback: @escaping ()->Void = {}) {
        self.windowNavigator.present(vc, animated: true, completion: callback)
    }
    
    override func nativeModalDismiss(_ callback: @escaping ()->() = {}) {
        self.windowNavigator.dismiss(animated: true, completion: { callback() })
    }
    
    func presentNotFullOverCurrent(vc: UIViewController, onCompletion: (() -> ())? = nil) {
        let navVC = windowNavigator.presentedViewController as? UINavigationController ?? windowNavigator
        vcsPresentedOver.append(vc)
        
        guard let viewToPresent = vc.view else { return }
        
        navVC.addChildViewController(vc)
        
        appearFading.showView(
            viewToPresent: viewToPresent,
            over: navVC.view,
            from: .bottom,
            onCompletion: onCompletion ?? {})
    }
    
    func unpresentNotFullOverCurrent(onCompletion: (() -> ())? = nil) {
        guard let vcPresentedOver = self.vcsPresentedOver.last else { return }
        
        appearFading.hideShownView(onCompletion: {
            vcPresentedOver.removeFromParentViewController()
            self.vcsPresentedOver.removeLast()
            onCompletion?()
        })
    }
    
    func presentOverCurrent(vc: UIViewController, animated: Bool = true, onCompletion: (() -> ())? = nil) {
        var baseVC = windowNavigator.parent ?? windowNavigator
        baseVC = baseVC.presentedViewController ?? baseVC
        
        vcsPresentedOver.append(vc)
        
        guard let viewToPresent = vc.view else { return }
        
        baseVC.addChildViewController(vc)
        baseVC.view.addSubview(viewToPresent)
        
        let bounds = UIScreen.main.bounds
        viewToPresent.frame = bounds
        viewToPresent.transform = CGAffineTransform(translationX: 0, y: bounds.height)
        
        UIView.animate(withDuration: animated ? animationDuration : 0.0, animations: {
            viewToPresent.transform = CGAffineTransform.identity
            }, completion: { _ in
                onCompletion?()
        })
    }
    
    
    func unpresentOverPresentedVC(animated: Bool = true, onCompletion: (() -> ())? = nil) {
        guard let vcPresentedOver = self.vcsPresentedOver.last else { return }
        guard let viewPresentedOverRootVC = vcPresentedOver.view else { return }
        
        let baseVC = windowNavigator.parent ?? windowNavigator
        
        UIView.animate(withDuration: animated ? animationDuration : 0.0, animations: {
            viewPresentedOverRootVC.transform = CGAffineTransform(translationX: 0, y: baseVC.view.bounds.height)
            }, completion: { _ in
                viewPresentedOverRootVC.removeFromSuperview()
                vcPresentedOver.removeFromParentViewController()
                if !self.vcsPresentedOver.isEmpty {
                  self.vcsPresentedOver.removeLast()
                }
                onCompletion?()
                
                viewPresentedOverRootVC.transform = .identity
        })
    }
    
}
