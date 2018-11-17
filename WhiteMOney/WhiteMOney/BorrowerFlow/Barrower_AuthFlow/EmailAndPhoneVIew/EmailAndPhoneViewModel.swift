//
//  EmailAndPhoneViewModel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 05/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit
import Async





class EmailAndPhoneViewModel: NSObject {

    var dataModel : Barrower_AuthDataModel!
    var emailAndPhoneVC : EmailAndPhoneVC?
    var fields = [Barrower_AuthDataModel.TypeOfCellField]()
    var fieldErrors = [Barrower_AuthDataModel.TypeOfCellField : String]()
    var didFinishStep : ()->Void = {}
    init(_ navigator : Navigator , dataModel : Barrower_AuthDataModel) {
        emailAndPhoneVC = EmailAndPhoneVC.instanciateFrom(storyboard: Storyboards.Barrower_AuthFlow)
        self.dataModel = dataModel
        super.init()
//        navigator.setAsRoot(emailAndPhoneVC!)
        emailAndPhoneVC?.onDidLoad(callback: { (emailAndPhoneVC) in
            self.regCellNib()
            self.setUpFieldsWithDataAndReload()
        })
    }
    func didFinishEmailAndPhonesStep(_ didFinishEmailAndPhonesVerify : @escaping ()->Void) -> Void {
        didFinishStep = didFinishEmailAndPhonesVerify
    }
    
    func setUpFieldsWithDataAndReload() -> Void {
        fields = [.fullName,.email,.password,.phoneNum ]

        if  dataModel.emailAndPhoneInfo.isOTPGenerated{
//            if dataModel.emailAndPhoneInfo.isOTPVerified{
//                fields.append(.otp)
//                fields.append(.nextWithCancel)
//
//            }else{
                fields.append(.otp)
                fields.append(.nextWithCancelOTP)
         //   }
        }else{
            dataModel.emailAndPhoneInfo.isOTPVerified = false
            fields.append(.nextBtn)
        }
        Async.main{
            self.emailAndPhoneVC?.fieldsTblView.reloadSections([0], with: .fade)
        }
    }
}

extension EmailAndPhoneViewModel:UITableViewDataSource,UITableViewDelegate{
    func regCellNib() -> Void {
        
        let nib = UINib.init(nibName: "FloatingTxtFieldCell", bundle: Bundle.main)
        emailAndPhoneVC?.fieldsTblView.register(nib, forCellReuseIdentifier: "FloatingTxtFieldCell")
        let otpnib = UINib.init(nibName: "OTPTextFieldCell", bundle: Bundle.main)
        emailAndPhoneVC?.fieldsTblView.register(otpnib, forCellReuseIdentifier: "OTPTextFieldCell")
        let buttonCellnib = UINib.init(nibName: "ButtonCell", bundle: Bundle.main)
        emailAndPhoneVC?.fieldsTblView.register(buttonCellnib, forCellReuseIdentifier: "ButtonCell")

        emailAndPhoneVC?.fieldsTblView.dataSource = self
        emailAndPhoneVC?.fieldsTblView.delegate = self
        emailAndPhoneVC?.fieldsTblView.reloadData()
        emailAndPhoneVC?.fieldsTblView.setDynamicCellHeight() 

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        let field = fields[indexPath.row]
        var isActive = true
        if  dataModel.emailAndPhoneInfo.isOTPGenerated{
//            if dataModel.emailAndPhoneInfo.isOTPVerified{
//
//            }else{
//                if field == .fullName || field == .phoneNum || field == .email || field == .nextBtn{
//                    isActive = false
//                }else{
//                    isActive = true
//                }
//            }
            if field == .otp || field == .nextWithCancelOTP{
                isActive = true
            }else{
                isActive = false
            }
            
        }else{
            isActive = true
        }
        
        switch field {
            
//        case .otp:
//            let OTPCell = tableView.dequeueReusableCell(withIdentifier: "OTPTextFieldCell") as! OTPTextFieldCell
//            OTPCell.dataModel = dataModel
//            OTPCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.OTP, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)
//            if isActive {
//                Async.main(after: 0.2, {
//                    OTPCell.beginEditField()
//                })
//            }
//            cell = OTPCell

        case .nextBtn,.nextWithCancelOTP,.nextWithCancel:
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            if field == .nextBtn{
                cellBtn.setAsMiddleBtnActive(true)
                cellBtn.middleNextBtn.addTarget(self, action: #selector(nextBtnAction), for: .touchUpInside)
            }else if field == .nextWithCancelOTP{
                cellBtn.setAsMiddleBtnActive(false)
                cellBtn.nextBtn.addTarget(self, action: #selector(OtpNextBtnActionOTP), for: .touchUpInside)
                cellBtn.backBtn.addTarget(self, action: #selector(OtpCancelBtnActionOTP), for: .touchUpInside)
            }else if field == .nextWithCancel{
                cellBtn.setAsMiddleBtnActive(false)
                cellBtn.nextBtn.addTarget(self, action: #selector(OtpNextBtnActionPassword), for: .touchUpInside)
                cellBtn.backBtn.addTarget(self, action: #selector(OtpCancelBtnActionPassword), for: .touchUpInside)
            }
            cell = cellBtn

        default:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            switch field{
            case .email:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.email, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self ,warningText: fieldErrors[field])

            case .phoneNum:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.phoneNum, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self ,warningText: fieldErrors[field])

            case .fullName:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.fullName, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self ,warningText:fieldErrors[field] )

            case .otp:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.OTP, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self ,warningText:fieldErrors[field] )
                    if isActive {
                        Async.main(after: 0.2, {
                            floatingTxtCell.floatingTxtView.txtField.becomeFirstResponder()
                        })
                    }
            case .password:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.password, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self ,warningText: fieldErrors[field])
                if isActive {
//                    Async.main(after: 0.2, {
//                        floatingTxtCell.floatingTxtView.txtField.becomeFirstResponder()
//                    })
                }

            default:
                break
            }
            
            
            cell = floatingTxtCell
        }
        cell.deactivateCell(!isActive)
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor.clear
        return cell
    }
    @objc func nextBtnAction() -> Void {
        emailAndPhoneVC?.view.endEditing(true)
        fieldErrors = validateFormGenerateOTP()
        if fieldErrors.count == 0{
            dataModel.emailAndPhoneInfo.isOTPGenerated = true
            setUpFieldsWithDataAndReload()
        }else{
            self.emailAndPhoneVC?.fieldsTblView.reloadData()
        }
    }
    @objc func OtpNextBtnActionOTP() -> Void {
        dataModel.emailAndPhoneInfo.isOTPVerified = true
//        setUpFieldsWithDataAndReload()
        didFinishStep()

    }
    @objc func OtpCancelBtnActionOTP() -> Void {
        dataModel.emailAndPhoneInfo.isOTPGenerated = false
        dataModel.emailAndPhoneInfo.isOTPVerified = false
        dataModel.emailAndPhoneInfo.OTP = ""
        setUpFieldsWithDataAndReload()
    }
    @objc func OtpNextBtnActionPassword() -> Void {
       didFinishStep()
    }
    @objc func OtpCancelBtnActionPassword() -> Void {
        dataModel.emailAndPhoneInfo.OTP = ""
        dataModel.emailAndPhoneInfo.password = ""
        dataModel.emailAndPhoneInfo.isOTPGenerated = false
        dataModel.emailAndPhoneInfo.isOTPVerified = false
        setUpFieldsWithDataAndReload()
    }
}
extension EmailAndPhoneViewModel: FloatingTxtFieldDelegate{
    func floatingTxtFieldShouldBeginEditing(_ textField: FloatingTxtField) -> Bool {
        return true
    }

    func floatingTxtFieldDidEndEditing(_ textField: FloatingTxtField, reason: UITextFieldDidEndEditingReason)
    {
        
        switch textField.placeHoleder {
        case Constants.passwordPlaceHolder:
            dataModel.emailAndPhoneInfo.password = textField.text ?? ""
        default:
            break
        }
    }
    func floatingTxtField(_ textField: FloatingTxtField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)

            switch textField.placeHoleder {
            case Constants.emailPlaceHolder:
                dataModel.emailAndPhoneInfo.email = updatedText
            case Constants.fullNamePlaceHolder:
                dataModel.emailAndPhoneInfo.fullName = updatedText
            case Constants.passwordPlaceHolder:
                dataModel.emailAndPhoneInfo.password = updatedText
            case Constants.phoneNumPlaceHolder:
                dataModel.emailAndPhoneInfo.phoneNum = updatedText
            case Constants.OTPPlaceHolder:
                dataModel.emailAndPhoneInfo.OTP = updatedText

            default:
                break
            }
            
        }
        return true
    }
    func floatingTxtFieldShouldClear(_ textField: FloatingTxtField) -> Bool {
        return true
    }
    
    
    func validateFormGenerateOTP() -> [Barrower_AuthDataModel.TypeOfCellField: String] {
        

        var errors = [Barrower_AuthDataModel.TypeOfCellField: String]()
        
        let emailAndPhoneInfoModel = dataModel.emailAndPhoneInfo
        
        if emailAndPhoneInfoModel.fullName.isEmpty {
            errors[Barrower_AuthDataModel.TypeOfCellField.fullName] = ErrorMessages.fullNameEmptyErrorMsg
        }
        if emailAndPhoneInfoModel.email.isEmpty {
            errors[Barrower_AuthDataModel.TypeOfCellField.email] = ErrorMessages.emailEmptyErrorMsg
        }else{
            if !emailAndPhoneInfoModel.email.isValidEmail(){
                errors[Barrower_AuthDataModel.TypeOfCellField.email] = ErrorMessages.emailInvalidErrorMsg
            }
        }
        if emailAndPhoneInfoModel.password.isEmpty {
            errors[Barrower_AuthDataModel.TypeOfCellField.password] = ErrorMessages.passwordEmptyErrorMsg
        }
        
        if emailAndPhoneInfoModel.phoneNum.isEmpty {
            errors[Barrower_AuthDataModel.TypeOfCellField.phoneNum] = ErrorMessages.phoneNumEmptyErrorMsg
        }
        
//        if !emailAndPhoneInfoModel.fullName.isEmpty {
//            if !emailAndPhoneInfoModel.email.isEmpty {
//                if !emailAndPhoneInfoModel.password.isEmpty {
//                    if !emailAndPhoneInfoModel.phoneNum.isEmpty {
//                        if emailAndPhoneInfoModel.email.isValidEmail(){
//
//                        }else{
////                            emailAndPhoneVC?.showCustomToast(message: ErrorMessages.emailInvalidErrorMsg)
//                            errors[Barrower_AuthDataModel.TypeOfCellField.email] = ErrorMessages.emailInvalidErrorMsg
//                        }
//                    }else{
////                        emailAndPhoneVC?.showCustomToast(message: ErrorMessages.phoneNumEmptyErrorMsg)
//                        errors[Barrower_AuthDataModel.TypeOfCellField.phoneNum] = ErrorMessages.phoneNumEmptyErrorMsg
//                    }
//                }else{
////                    emailAndPhoneVC?.showCustomToast(message: ErrorMessages.passwordEmptyErrorMsg)
//                    errors[Barrower_AuthDataModel.TypeOfCellField.password] = ErrorMessages.passwordEmptyErrorMsg
//                }
//            }else{
////                emailAndPhoneVC?.showCustomToast(message: ErrorMessages.emailEmptyErrorMsg)
//                errors[Barrower_AuthDataModel.TypeOfCellField.email] = ErrorMessages.emailEmptyErrorMsg
//            }
//        }else{
////            emailAndPhoneVC?.showCustomToast(message: ErrorMessages.fullNameEmptyErrorMsg)
//            errors[Barrower_AuthDataModel.TypeOfCellField.fullName] = ErrorMessages.fullNameEmptyErrorMsg
//        }
        return errors
    }
}




