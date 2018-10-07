//
//  AppearFading.swift
//  WhiteMoney
//
//  Created by Exequiel Banga on 10/19/16.
//  Copyright © 2016 codika. All rights reserved.
//

import UIKit

class AppearFading: NSObject {
    
    fileprivate var bgView = UIView()
    fileprivate var animationDuration: TimeInterval = 0.6
    fileprivate var viewToPresent: UIView?
    fileprivate var parentView: UIView?
    
    enum Direction {
        case bottom
    }
    
    override init() {
        
    }
    
    func showView(viewToPresent: UIView, over parentView: UIView, from direction: Direction, onCompletion: @escaping ()->()) {
        if self.viewToPresent != nil {
            return
        }
        
        self.viewToPresent = viewToPresent
        self.parentView = parentView
        
        viewToPresent.backgroundColor = UIColor.clear
        
        bgView.frame = parentView.bounds
        
        bgView.addSubview(viewToPresent)
        parentView.addSubview(bgView)
        
        viewToPresent.frame = parentView.bounds
        viewToPresent.transform = CGAffineTransform(translationX: 0, y: parentView.bounds.height)
        
        bgView.backgroundColor = UIColor.clear
        UIView.animate(withDuration: animationDuration, animations: {
            viewToPresent.transform = CGAffineTransform.identity
            self.bgView.backgroundColor = UIColor.WhiteMoney_darkBlue.withAlphaComponent(0.8)
            }, completion: { _ in
                onCompletion()
        })
    }
    
    func hideShownView(onCompletion: (() -> ())?) {
        guard let viewToUnpresent = viewToPresent else { return }
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.bgView.backgroundColor = UIColor.WhiteMoney_darkBlue.withAlphaComponent(0.0)
            viewToUnpresent.transform = CGAffineTransform(translationX: 0, y: self.parentView!.bounds.height)
            }, completion: { _ in
                viewToUnpresent.transform = CGAffineTransform.identity
                self.bgView.removeFromSuperview()
                viewToUnpresent.removeFromSuperview()
                self.viewToPresent = nil
                onCompletion?()
        })
    }
}
