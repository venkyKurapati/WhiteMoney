//
//  AuthFlow.swift
//  DesignWithAnchors
//
//  Created by Venkatesh on 05/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit
import Async

class AuthFlow: NSObject {
    enum AuthSteps : String{
        case emailAndPhoneNum = "emailAndPhoneNum"
        case eligibility = "eligibility"
        case documentsUpload = "documentsUpload"
    }
    
    var authMainVC : AuthViewController!
    var emailAndPhoneModel : EmailAndPhoneViewModel?
    var eligibilityCheckModel : EligibilityCheckViewModel?
    var documentsUploadModel : DocumentsUploadViewModel?
    var navigator : Navigator!
    var authPageVC : AuthPageViewController!
    var authUserDetails = AuthDataModel(nil)
    
    
    init(_ navigator : Navigator) {
        self.navigator = navigator
        emailAndPhoneModel = EmailAndPhoneViewModel.init(navigator, dataModel: authUserDetails)
        eligibilityCheckModel = EligibilityCheckViewModel.init(navigator)
        documentsUploadModel = DocumentsUploadViewModel.init(navigator)
        authPageVC = AuthPageViewController.instanciateFrom(storyboard: Storyboards.authFlow)
        super.init()
        emailAndPhoneModel?.didFinishEmailAndPhonesStep {
            Async.main{
                self.authMainVC.stepsItemsView.chaangeStepTo(1)
                self.authPageVC.setShowingVC(1)
            }
        }
        eligibilityCheckModel?.didFinishEligibilityStep {
            Async.main{
                self.authMainVC.stepsItemsView.chaangeStepTo(2)
                self.authPageVC.setShowingVC(2)
            }
        }
        eligibilityCheckModel?.didCancelEligibilityStep {
            Async.main{
                self.authMainVC.stepsItemsView.chaangeStepTo(0)
                self.authPageVC.setShowingVC(0)
            }
        }
        documentsUploadModel?.didFinishUploadDocStep {
            Async.main{
//                self.authMainVC.stepsItemsView.chaangeStepTo(0)
//                self.authPageVC.setShowingVC(0)
                let borrowerFlow = BorrowerHomeViewModel(self.navigator)
                borrowerFlow.run()
            }
        }
        documentsUploadModel?.didCancelEligibilityStep {
            Async.main{
                self.authMainVC.stepsItemsView.chaangeStepTo(1)
                self.authPageVC.setShowingVC(1)
            }
        }
    }
    func runAuthFlow() -> Void {
        authMainVC = AuthViewController.instanciateFrom(storyboard: Storyboards.authFlow)
       // self.navigator?.setAsRoot(authMainVC!)
        self.navigator?.windowNavigator.viewControllers = [authMainVC]
        authMainVC?.onDidLoad(callback: { (authvc) in
            
            self.authMainVC?.addChildViewController(self.authPageVC!)
            self.authPageVC?.view.frame = self.authMainVC.fieldsContentView.bounds
            self.authMainVC?.fieldsContentView.addSubview(self.authPageVC?.view! ?? UIView())
            self.authPageVC?.didMove(toParentViewController: self.authMainVC)
            self.authPageVC.orderedViewControllers = [self.emailAndPhoneModel?.emailAndPhoneVC!,self.eligibilityCheckModel?.eligibilityVC!,self.documentsUploadModel?.documentsUploadVC!] as! [UIViewController]

        })

    }

  
    
}
