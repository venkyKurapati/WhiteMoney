//
//  Storyboard.swift
//  WhiteMoney2
//
//  Created by Leandro Linardos on 26/03/2018.
//  Copyright © 2018 Leandro Linardos. All rights reserved.
//

import UIKit

//
//  Storyboard.swift
//  iguazu
//
//  Created by Leandro Linardos on 6/13/17.
//  Copyright © 2017 codika. All rights reserved.
//

import UIKit

protocol Storyboard {
    var filename: String { get }
}

extension UIStoryboard {
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    func instantiateViewController<VC:UIViewController>() -> VC {
        guard let viewController = self.instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC else {
            fatalError("Couldn't instantiate view controller with identifier \(VC.storyboardIdentifier) ")
        }
        return viewController
    }
    
    func instantiateInitial<VC:UIViewController>() -> VC {
        guard let viewController = self.instantiateInitialViewController() as? VC else {
            fatalError("Couldn't instantiate initial view controller with type \(VC.description()) ")
        }
        return viewController
    }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension UIViewController: StoryboardIdentifiable {
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

protocol StoryboardInstantiable {
}

extension UIViewController: StoryboardInstantiable {
}

extension StoryboardInstantiable where Self: UIViewController {
    internal static func instanciateFrom(storyboard: Storyboard) -> Self {
        return UIStoryboard(storyboard: storyboard).instantiateViewController()
    }
    
    internal static func instanciateInitialFrom(storyboard: Storyboard) -> Self {
        return UIStoryboard(storyboard: storyboard).instantiateInitial()
    }
    
    internal static func instanciateFrom(storyboard: UIStoryboard) -> Self {
        return storyboard.instantiateViewController(withIdentifier: Self.storyboardIdentifier) as! Self
    }
}


protocol XibIdentifiable {
    static var xibFilename: String { get }
}

extension UIViewController: XibIdentifiable {
}

extension XibIdentifiable where Self: UIViewController {
    static var xibFilename: String {
        return String(describing: self)
    }
}

protocol XibInstantiable {
}

extension UIViewController: XibInstantiable {
}

extension XibInstantiable where Self: UIViewController {
    internal static func instantiateFromXib() -> Self {
        return Self.init(nibName: self.xibFilename, bundle: Bundle.main)
    }
}


