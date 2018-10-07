//
//  EmailAndPhoneViewModel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 05/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class EmailAndPhoneViewModel: NSObject {

    var dataModel : AuthDataModel!
    var emailAndPhoneVC : EmailAndPhoneVC?
    var fields = [TypeOfCellField]()
    
    
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
    func setUpFieldsWithDataAndReload() -> Void {
        fields = [.fullName,.email,.phoneNum ]

        if  dataModel.isOTPGenerated{
            if dataModel.isOTPVerified{
                fields.append(.otp)
                fields.append(.password)

            }else{
                fields.append(.otp)
                fields.append(.nextWithCancel)
            }
        }else{
            fields.append(.nextBtn)
        }
        emailAndPhoneVC?.fieldsTblView.reloadSections([0], with: .fade)
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
        switch field {
        case .otp:
            cell = tableView.dequeueReusableCell(withIdentifier: "OTPTextFieldCell") as! OTPTextFieldCell
        case .nextBtn,.nextWithCancel:
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
            if field == .nextBtn{
                cellBtn.setAsMiddleBtnActive(true)
                cellBtn.middleNextBtn.addTarget(self, action: #selector(nextBtnAction), for: .touchUpInside)
            }else{
                cellBtn.setAsMiddleBtnActive(false)
                cellBtn.nextBtn.addTarget(self, action: #selector(OtpNextBtnAction), for: .touchUpInside)
                cellBtn.backBtn.addTarget(self, action: #selector(OtpCancelBtnAction), for: .touchUpInside)

            }
            cell = cellBtn

        default:
            let floatingTxtCell = tableView.dequeueReusableCell(withIdentifier: "FloatingTxtFieldCell") as! FloatingTxtFieldCell
            switch field{
            case .email:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.email, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)

            case .phoneNum:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.phoneNum, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)

            case .fullName:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.fullName, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)

            case .password:
                floatingTxtCell.setUpUserFieldDetailsOfUser(dataModel.password, typeOfTxtField: fields[indexPath.row], inputAccessoryView: nil, delegate: self)

            default:
                break
            }
            
            
            cell = floatingTxtCell
        }
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor.appBlue
        return cell
    }
    @objc func nextBtnAction() -> Void {
        dataModel.isOTPGenerated = true
        setUpFieldsWithDataAndReload()
    }
    @objc func OtpNextBtnAction() -> Void {
        dataModel.isOTPVerified = true
        setUpFieldsWithDataAndReload()
    }
    @objc func OtpCancelBtnAction() -> Void {
        dataModel.isOTPGenerated = false
        dataModel.OTP = ""
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
                dataModel.email = updatedText
            case Constants.fullNamePlaceHolder:
                dataModel.fullName = updatedText
            case Constants.passwordPlaceHolder:
                dataModel.password = updatedText
            case Constants.phoneNumPlaceHolder:
                dataModel.phoneNum = updatedText
                
            default:
                break
            }        }
        return true
    }

}




