//
//  Navigator.swift
//  WhiteMoney
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
    private(set) var rootVC: UINavigationController
    private var vcsPresentedOver = [UIViewController]()
    private var animationDuration: TimeInterval = 0.3
    
    
    private var appearFading = AppearFading()
    
  
    
    init(rootVC: UINavigationController, sideMenu: SideMenuFeature?) {
        self.sideMenu = sideMenu
        self.rootVC = rootVC        
        rootVC.setNavigationBarHidden(true, animated: false)
    }
    
    func setAsRoot(_ vc: UIViewController) {
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(onShowMenu))
        vc.navigationItem.title = "White Money"
        self.rootVC.setNavigationBarHidden(false, animated: true)
        self.rootVC.setViewControllers([vc], animated: true)
    }
    
    func restart(with vc: UIViewController) {
//        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "root_hamburger"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(onShowMenu))
//        vc.navigationItem.title = "WhiteMoney"
        if (vcsPresentedOver.count != 0) {
            self.unpresentOverPresentedVC()
        }
        
        self.rootVC.setNavigationBarHidden(true, animated: true)
        self.rootVC.setViewControllers([vc], animated: false)
    }
    
    @objc func onShowMenu() {
        sideMenu?.toogle(animated: true)
    }
    
    override func push<T: UIViewController>(_ vc: T, animated: Bool = true, callback: @escaping (T)->Void = { _ in }) {
        let navVC = rootVC.presentedViewController as? UINavigationController ?? rootVC
        WillAppearDelegate(vc: vc, callback: { vc in
            callback(vc as! T)
        }).assign(to: navVC)
        
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navVC.topViewController?.navigationItem.backBarButtonItem = item
        navVC.pushViewController(vc, animated: animated)
    }
    
    override func pop() {
        let navVC = rootVC.presentedViewController as? UINavigationController ?? rootVC
        navVC.popViewController(animated: true)
    }
    
    override func pushReplacingCurrent<T: UIViewController>(_ vc: T, callback: @escaping (T)->Void) {
        WillAppearDelegate(vc: vc, callback: { vc in
            callback(vc as! T)
        }).assign(to: self.rootVC)
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.rootVC.topViewController?.navigationItem.backBarButtonItem = item
        var vcs = self.rootVC.viewControllers
        vcs.removeLast()
        vcs.append(vc)
        self.rootVC.setViewControllers(vcs, animated: true)
    }
    
    func popToRoot(callback: @escaping ()->Void = {}) {
        WillAppearDelegate(vc: self.rootVC.viewControllers.first!, callback: { vc in
            callback()
        }).assign(to: self.rootVC)
        self.rootVC.popToRootViewController(animated: true)
    }
    
    override func nativeModal(vc: UIViewController, callback: @escaping ()->Void = {}) {
        self.rootVC.present(vc, animated: true, completion: callback)
    }
    
    override func nativeModalDismiss(_ callback: @escaping ()->() = {}) {
        self.rootVC.dismiss(animated: true, completion: { callback() })
    }
    
    func presentNotFullOverCurrent(vc: UIViewController, onCompletion: (() -> ())? = nil) {
        let navVC = rootVC.presentedViewController as? UINavigationController ?? rootVC
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
        var baseVC = rootVC.parent ?? rootVC
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
        
        let baseVC = rootVC.parent ?? rootVC
        
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
class NavigationController: UINavigationController {
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
