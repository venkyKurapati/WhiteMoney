//
//  AlertsPresenter.swift
//  whitemoney
//
//  Created by Exequiel Banga on 10/12/16.
//  Copyright © 2016 codika. All rights reserved.
//

import UIKit

//class AlertsPresenter: NSObject {
//    private var rootVC: UIViewController
////    private var vcPresentedOver: ChatBotAlertController?
//    private var appearFading = AppearFading()
//    
//    init(rootVC: UIViewController) {
//        self.rootVC = rootVC
//    }
//    
////    func present(alertVC: ChatBotAlertController, onCompletion: (() -> ())?) {
////        if (vcPresentedOver != nil) {
////            return
////        }
////
////        vcPresentedOver = alertVC
////
////        alertVC.onLeaveAction = { self.unpresent() }
////
////        rootVC.addChildViewController(alertVC)
////
////        appearFading.showView(
////            viewToPresent: vcPresentedOver!.view,
////            over: rootVC.view,
////            from: .bottom,
////            onCompletion: onCompletion ?? {})
////    }
//    
////    func present(alertVC: ChatBotAlertController) {
////        present(alertVC: alertVC, onCompletion: nil)
////    }
////
////    private func unpresent(onCompletion: (() -> ())?) {
////        guard let vcPresentedOver = self.vcPresentedOver else {
////            return
////        }
////
////        appearFading.hideShownView(onCompletion: {
////            vcPresentedOver.removeFromParentViewController()
////            self.vcPresentedOver = nil
////            onCompletion?()
////        })
////    }
//    
////    private func unpresent() {
////        unpresent(onCompletion: nil)
////    }
//    
//    func presentNativeAlert(title: String?, message: String?, onClose closeCallback: @escaping ()->Void = {}) {
//        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
//            _ in closeCallback()
//        }))
//        let navVC = rootVC.presentedViewController as? UINavigationController ?? rootVC
//        navVC.present(alertController, animated: true, completion: nil)
//    }
//    
//    func presentAlertController(_ alertController: UIAlertController) {
//        let navVC = rootVC.presentedViewController as? UINavigationController ?? rootVC
//        navVC.present(alertController, animated: true, completion: nil)
//    }
//    
//    func presentError(message: String, onClose closeCallback: @escaping ()->Void = {}) {
//        presentNativeAlert(title: "Error", message: message, onClose: closeCallback)
//    }
//    
//    func presentInfo(message: String, onClose closeCallback: @escaping ()->Void = {}) {
//        presentNativeAlert(title: "Info", message: message, onClose: closeCallback)
//    }
//    
//    func present(message: String, onClose closeCallback: @escaping ()->Void = {}) {
//        presentNativeAlert(title: "", message: message, onClose: closeCallback)
//    }
//}
