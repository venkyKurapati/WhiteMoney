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

    var dataModel : AuthDataModel!
    var emailAndPhoneVC : EmailAndPhoneVC?
    var fields = [AuthDataModel.TypeOfCellField]()
    
    var didFinishStep : ()->Void = {}
    init(_ navigator : Navigator , dataModel : AuthDataModel) {
        emailAndPhoneVC = EmailAndPhoneVC.instanciateFrom(storyboard: Storyboards.authFlow)
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
        fields = [.fullName,.email,.phoneNum ]

        if  dataModel.emailAndPhoneInfo.isOTPGenerated{
            if dataModel.emailAndPhoneInfo.isOTPVerified{
                fields.append(.otp)
                fields.append(.password)
                fields.append(.nextWithCancelPassword)

            }else{
                fields.append(.otp)
                fields.append(.nextWithCancelOTP)
            }
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
            if dataModel.emailAndPhoneInfo.isOTPVerified{
                if field == .fullName || field == .phoneNum || field == .email || field == .nextBtn || field == .otp || field == .nextWithCancelOTP{
                    isActive = false
                }else{
                    isActive = true
                }
            }else{
                if field == .fullName || field == .phoneNum || field == .email || field == .nextBtn{
                    isActive = false
                }else{
                    isActive = true
                }
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

        case .nextBtn,.nextWithCancelOTP,.nextWithCancelPassword:
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            if field == .nextBtn{
                cellBtn.setAsMiddleBtnActive(true)
                cellBtn.middleNextBtn.addTarget(self, action: #selector(nextBtnAction), for: .touchUpInside)
            }else if field == .nextWithCancelOTP{
                cellBtn.setAsMiddleBtnActive(false)
                cellBtn.nextBtn.addTarget(self, action: #selector(OtpNextBtnActionOTP), for: .touchUpInside)
                cellBtn.backBtn.addTarget(self, action: #selector(OtpCancelBtnActionOTP), for: .touchUpInside)
            }else if field == .nextWithCancelPassword{
                cellBtn.setAsMiddleBtnActive(false)
                cellBtn.nextBtn.addTarget(self, action: #selector(OtpNextBtnActionPassword), for: .touchUpInside)
                cellBtn.backBtn.addTarget(self, action: #selector(OtpCancelBtnActionPassword), for: .touchUpInside)
            }
            cell = cellBtn

        default:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            switch field{
            case .email:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.email, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)

            case .phoneNum:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.phoneNum, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)

            case .fullName:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.fullName, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)

            case .otp:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.OTP, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)
                    if isActive {
                        Async.main(after: 0.2, {
                            floatingTxtCell.floatingTxtView.txtField.becomeFirstResponder()
                        })
                    }
            case .password:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.emailAndPhoneInfo.password, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)
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
        dataModel.emailAndPhoneInfo.isOTPGenerated = true
        setUpFieldsWithDataAndReload()
    }
    @objc func OtpNextBtnActionOTP() -> Void {
        dataModel.emailAndPhoneInfo.isOTPVerified = true
        setUpFieldsWithDataAndReload()
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
    func floatingTxtFieldDidEndEditing(_ textField: FloatingTxtField) {
        

    }
    func floatingTxtFieldDidEndEditing(_ textField: FloatingTxtField, reason: UITextFieldDidEndEditingReason)
    {
        self.floatingTxtFieldDidEndEditing(textField)
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
            case Constants.OTPPlaceHolde:
                dataModel.emailAndPhoneInfo.OTP = updatedText

            default:
                break
            }
            
        }
        return true
    }

}




