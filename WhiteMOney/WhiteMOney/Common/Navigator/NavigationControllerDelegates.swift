//
//  NavigationControllerDelegates.swift
//  WhiteMoney2
//
//  Created by Leandro Linardos on 24/04/2018.
//  Copyright © 2018 Leandro Linardos. All rights reserved.
//

import UIKit

class UINavigationControllerComposedDelegate: NSObject, UINavigationControllerDelegate {
    var willAppearDelegates: [WillAppearDelegate] = []
    var didAppearDelegates: [DidAppearDelegate] = []
    private static var instances: [UINavigationControllerComposedDelegate] = []
    
    override init() {
        super.init()
        UINavigationControllerComposedDelegate.instances.append(self)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        willAppearDelegates.forEach { $0.navigationController(navigationController, willShow: viewController, animated: animated) }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        didAppearDelegates.forEach { $0.navigationController(navigationController, didShow: viewController, animated: animated) }
    }
}

class WillAppearDelegate: NSObject {
    private var vc: UIViewController
    private var callback: (UIViewController)->() = { _ in }
    private var composedDelegate: UINavigationControllerComposedDelegate!
    
    init(vc: UIViewController, callback: @escaping (UIViewController)->()) {
        self.vc = vc
        self.callback = callback
    }
    
    func assign(to navVC: UINavigationController) {
        if let composedDelegate = navVC.delegate as? UINavigationControllerComposedDelegate {
            self.composedDelegate = composedDelegate
            self.composedDelegate?.willAppearDelegates.append(self)
        } else {
            navVC.delegate = UINavigationControllerComposedDelegate()
            self.assign(to: navVC)
        }
        // TODO another assigned delegate
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard viewController == self.vc else { return }
        
        callback(viewController)
        self.composedDelegate.willAppearDelegates = self.composedDelegate.willAppearDelegates.filter { $0 != self }
    }
}

class DidAppearDelegate: NSObject {
    private var vc: UIViewController
    private var callback: (UIViewController)->() = { _ in }
    private var composedDelegate: UINavigationControllerComposedDelegate!
    
    init(vc: UIViewController, callback: @escaping (UIViewController)->()) {
        self.vc = vc
        self.callback = callback
    }
    
    func assign(to navVC: UINavigationController) {
        if let composedDelegate = navVC.delegate as? UINavigationControllerComposedDelegate {
            self.composedDelegate = composedDelegate
            self.composedDelegate?.didAppearDelegates.append(self)
        } else {
            navVC.delegate = UINavigationControllerComposedDelegate()
            self.assign(to: navVC)
        }
        // TODO another assigned delegate
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard viewController == self.vc else { return }
        
        callback(viewController)
        self.composedDelegate.didAppearDelegates = self.composedDelegate.didAppearDelegates.filter { $0 != self }
    }
}
