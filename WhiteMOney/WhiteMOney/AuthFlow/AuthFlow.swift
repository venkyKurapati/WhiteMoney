//
//  AuthFlow.swift
//  DesignWithAnchors
//
//  Created by Venkatesh on 05/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class AuthFlow: NSObject {
    
    
    
    var authMainVC : AuthViewController!
    var emailAndPhoneModel : EmailAndPhoneViewModel?
    var eligibilityCheckModel : EligibilityCheckViewModel?
    var documentsUploadModel : DocumentsUploadViewModel?
    var navigator : Navigator?
    var authPageVC : AuthPageViewController!
    var authUserDetails = AuthDataModel()
    
    
    init(_ navigator : Navigator) {
        self.navigator = navigator
        emailAndPhoneModel = EmailAndPhoneViewModel.init(navigator, dataModel: authUserDetails)
        eligibilityCheckModel = EligibilityCheckViewModel.init(navigator)
        documentsUploadModel = DocumentsUploadViewModel.init(navigator)
        authPageVC = AuthPageViewController.instanciateFrom(storyboard: Storyboards.authFlow)
        super.init()
        runAuthFlow()
    }
    func runAuthFlow() -> Void {
        authMainVC = AuthViewController.instanciateFrom(storyboard: Storyboards.authFlow)
        self.navigator?.setAsRoot(authMainVC!)
        authMainVC?.onDidLoad(callback: { (authvc) in
            
            self.authMainVC?.addChildViewController(self.authPageVC!)
            self.authPageVC?.view.frame = self.authMainVC.fieldsContentView.bounds
            self.authMainVC?.fieldsContentView.addSubview(self.authPageVC?.view! ?? UIView())
            self.authPageVC?.didMove(toParentViewController: self.authMainVC)
            self.authPageVC.orderedViewControllers = [self.emailAndPhoneModel?.emailAndPhoneVC!,self.eligibilityCheckModel?.eligibilityVC!,self.documentsUploadModel?.documentsUploadVC!] as! [UIViewController]

        })

    }

  
    
}
