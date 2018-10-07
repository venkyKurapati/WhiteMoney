//
//  SideMenuFeature.swift
//  WhiteMoney
//
//  Created by Exequiel Banga on 9/29/16.
//  Copyright © 2016 codika. All rights reserved.
//

import UIKit

class SideMenuFeature: NSObject {
    
    private let sideOffset: CGFloat = 0
    init(on parentVC: UIViewController, with contentVC: UIViewController) {
        sideMenuController = SideMenuViewController.instanciateFrom(storyboard: Storyboards.main)
        
        self.parentVC = parentVC
        
        parentVC.addChildViewController(contentVC)
        parentVC.view.addSubview(contentVC.view)
        
        contentVC.view.translatesAutoresizingMaskIntoConstraints = false
        contentVC.view.topAnchor.constraint(equalTo: parentVC.view.topAnchor).isActive = true
        contentVC.view.bottomAnchor.constraint(equalTo: parentVC.view.bottomAnchor).isActive = true
        contentVC.view.leftAnchor.constraint(equalTo: parentVC.view.leftAnchor).isActive = true
        contentVC.view.rightAnchor.constraint(equalTo: parentVC.view.rightAnchor).isActive = true

        parentVC.addChildViewController(sideMenuController)
        parentVC.view.addSubview(sideMenuController.view)
        
//        self.panToShowMenuView = sideMenuController.panToAppearView
        
        sideMenuController.view.translatesAutoresizingMaskIntoConstraints = false
        sideMenuController.view.topAnchor.constraint(equalTo: parentVC.view.topAnchor).isActive = true
        sideMenuController.view.widthAnchor.constraint(equalTo: parentVC.view.widthAnchor, multiplier: 1.0, constant: -60 + sideOffset).isActive = true
        sideMenuController.view.bottomAnchor.constraint(equalTo: parentVC.view.bottomAnchor).isActive = true
        
        leadingConstraint = sideMenuController.view.leftAnchor.constraint(equalTo: parentVC.view.leftAnchor, constant: 0)
        leadingConstraint.isActive = true

        blockView = UIView()
        blockView.backgroundColor = UIColor(hex: 0x1b1b2c)
        parentVC.view.addSubview(blockView)
        
        blockView.translatesAutoresizingMaskIntoConstraints = false
        blockView.topAnchor.constraint(equalTo: parentVC.view.topAnchor).isActive = true
        blockView.bottomAnchor.constraint(equalTo: parentVC.view.bottomAnchor).isActive = true
        blockView.leftAnchor.constraint(equalTo: parentVC.view.leftAnchor).isActive = true
        blockView.rightAnchor.constraint(equalTo: parentVC.view.rightAnchor).isActive = true
        
        parentVC.view.bringSubview(toFront: sideMenuController.view)
        
        super.init()
        
//        sideMenuController.onDidLayoutDo({ (vc) in
//            self.hide(animated: false)
//        })
        
        hideMenuTapGesture = UITapGestureRecognizer(target: self, action: #selector(onHideMenuTap))
        blockView.addGestureRecognizer(hideMenuTapGesture)
        
        
        panToHideFromBlockViewGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(gestureRecognizer:)))
        blockView.addGestureRecognizer(panToHideFromBlockViewGesture)
        
        panToShowGesture = UIPanGestureRecognizer(target: self, action: #selector(panFromSide(gestureRecognizer:)))
        sideMenuController.view.addGestureRecognizer(panToShowGesture)
        
        panToHideGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(gestureRecognizer:)))
        sideMenuController.view.addGestureRecognizer(panToHideGesture)
        
//        sideMenuController.onWillAppearDo { _ in
//            self.hide(animated: false)
//        }
        self.hide(animated: false)
        self.parentVC.view.layoutSubviews()
    }
    
    func set(headerOption option: SideMenuOption) {
        headerOption = option
        sideMenuController.onHeaderTap = { [headerOption] in
            headerOption?.onSelect?()
        }
    }
    
    func set(options: [SideMenuOption]) {
        self.options = SideMenuOptions(options: options)
        self.options.show(on: sideMenuController.tableView)
    }

    func show(animated: Bool = false) {
        onWillShow()
        modifyLeadingContraint(constant: 0, animated: animated, onCompletion: {
            self.onDidShow()
            self.panToHideGesture.isEnabled = true
            self.panToShowGesture.isEnabled = false
            self.panToHideFromBlockViewGesture.isEnabled = true
        })
        block(animated: animated)
    }
    func onWillShowDo(_ callback: @escaping ()->()) {
        onWillShow = callback
    }
    func onDidShowDo(_ callback: @escaping ()->()) {
        onDidShow = callback
    }
    
    func preload() {
//        sideMenuController.view.isHidden = true
//        show(animated: true)
//        OperationQueue.main.addOperation {
//            self.hide(animated: true)
//            self.sideMenuController.view.isHidden = false
//        }
    }

    func hide(animated: Bool = false) {
        onWillHide()
        modifyLeadingContraint(constant: -sideMenuController.view.frame.size.width + sideOffset, animated: animated, onCompletion: {
            self.onDidHide()
            self.panToHideGesture.isEnabled = false
            self.panToShowGesture.isEnabled = true
            self.panToHideFromBlockViewGesture.isEnabled = false
        })
        unblock(animated: animated)
        isShowing = false
    }
    func onWillHideDo(_ callback: @escaping ()->()) {
        onWillHide = callback
    }
    func onDidHideDo(_ callback: @escaping ()->()) {
        onWillShow = callback
    }
    
    func toogle(animated: Bool = false) {
        if (isShowing == true) {
            hide(animated: animated)
        } else {
            sideMenuController.show()
            show(animated: animated)
        }
    }
    
    private(set) var isShowing: Bool = false
    private var parentVC: UIViewController
    var sideMenuController: SideMenuViewController
    private var showHideAnimationDuration: Double = 0.4
    private var panToShowMenuView: UIView?
    private var panToHideGesture: UIPanGestureRecognizer!
    private var panToShowGesture: UIPanGestureRecognizer!
    private var panToHideFromBlockViewGesture: UIPanGestureRecognizer!
    private var options = SideMenuOptions(options: [])
    private var onWillShow: ()->() = {}
    private var onDidShow: ()->() = {}
    private var onWillHide: ()->() = {}
    private var onDidHide: ()->() = {}
    private var leadingConstraint: NSLayoutConstraint
    private var blockView: UIView
    private var hideMenuTapGesture: UITapGestureRecognizer!
    
    private var headerOption: SideMenuOption?
    
    @objc private func panFromSide(gestureRecognizer: UIPanGestureRecognizer) {
        let touchX = gestureRecognizer.location(in: panToShowMenuView?.superview).x
        
        let xPos = touchX
        let isLastTouch = gestureRecognizer.state == .ended
        moveMenuTo(x: xPos, isLastTouch: isLastTouch)
    }
    
    fileprivate var firstTouchX: CGFloat?
    @objc private func pan(gestureRecognizer: UIPanGestureRecognizer) {
        let magicValue = sideMenuController.view.frame.size.width
        let touchX = gestureRecognizer.location(in: panToShowMenuView?.superview).x
        if firstTouchX == nil {
            firstTouchX = touchX
            return
        }
        
        let isLastTouch = gestureRecognizer.state == .ended
        
        let xPos = magicValue - (firstTouchX! - touchX)
        moveMenuTo(x: xPos, isLastTouch: isLastTouch)
        
        if (isLastTouch) {
            firstTouchX = nil
        }
    }
    
    fileprivate func moveMenuTo(x: CGFloat, isLastTouch: Bool) {
        let magicValue = sideMenuController.view.frame.size.width
        if (isLastTouch) {
            if (x > magicValue/2.0) {
                show(animated: true)
            } else {
                hide(animated: true)
            }
        } else {
            let constraintOffset = min(-magicValue + x, 0)
            modifyLeadingContraint(constant: constraintOffset, animated: false, onCompletion: nil)
         
            let blockRatio = abs(constraintOffset/magicValue)
            self.blockView.alpha = (1.0 - blockRatio)*0.9
            self.blockView.isHidden = false
        }
    }
    
    private func modifyLeadingContraint(constant: CGFloat,
                                        animated: Bool,
                                        onCompletion: (()->())?) {
        leadingConstraint.constant = constant
        self.sideMenuController.view.setNeedsLayout()
        
        if (animated) {
            UIView.animate(withDuration: showHideAnimationDuration, animations: { 
                self.parentVC.view.layoutIfNeeded()
                }, completion: { _ in
                onCompletion?()
            })
        }
    }
    
    @objc private func onHideMenuTap() {
        hide(animated: true)
    }
    
    private func block(animated: Bool) {
        hideMenuTapGesture.isEnabled = true
        blockView.isHidden = false
        
        if (animated == true) {
            UIView.animate(withDuration: showHideAnimationDuration, animations: {
                self.blockView.alpha = 0.9
            })
        } else {
            self.blockView.alpha = 0.9
        }
    }
    
    private func unblock(animated: Bool) {
        hideMenuTapGesture.isEnabled = false
        if (animated == true) {
            UIView.animate(withDuration: showHideAnimationDuration, animations: {
                self.blockView.alpha = 0.0
            }) { _ in
                self.blockView.isHidden = true
            }
        } else {
            self.blockView.alpha = 0.0
            self.blockView.isHidden = true
        }
    }
    
}

class SideMenuOptions : NSObject, UITableViewDelegate , UITableViewDataSource {
    private var options: [SideMenuOption] = []
    init(options: [SideMenuOption]) {
        self.options = options
    }
    func show(on tableView: UITableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return options.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        cell.optionImageView.image = optionAt(indexPath).image
        cell.optionLabel.text = optionAt(indexPath).name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        optionAt(indexPath).onSelect!()
    }
    
    fileprivate func optionAt(_ indexPath: IndexPath) -> SideMenuOption {
        return options[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}
