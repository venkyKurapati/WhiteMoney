//
//  OTPTextFieldCell.swift
//  WhiteMOney
//
//  Created by Venkatesh on 06/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit
import Async
class OTPTextFieldCell: UITableViewCell {

    var delegate : FloatingTxtFieldDelegate?
    var dataModel : AuthDataModel?
    @IBOutlet weak var dummyTxtField: UITextField!
    var OTPFieldsCount = 4
    var isFieldEditing  : Bool = false{
        didSet{
            var letters = OTPtext.characters.map { String($0) }
            while letters.count < OTPFieldsCount {
                letters.append("")
            }
            var i = 0
            while i < OTPFieldsCount{
                let fieldTag = 100 + i
                if let otpField = self.contentView.viewWithTag(fieldTag) as? OTPField{
                    otpField.setUpTxtFieldColor(UIColor.appPrimaryTextColor(), underLineViewColor: UIColor.fieldBackgroundColor())
                    if OTPtext.count+100 == fieldTag && isFieldEditing{
                        otpField.startEdit()
                    }else{
                        otpField.endEdit()
                    }
                }
                i += 1
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isFieldEditing = false
        dummyTxtField.delegate = self
    }
    func beginEditField() -> Void {
        dummyTxtField.becomeFirstResponder()
    }
    var OTPtext : String = "" {
        didSet{
            
            var letters = OTPtext.characters.map { String($0) }
            while letters.count < OTPFieldsCount {
                letters.append("")
            }
            var i = 0
            while i < OTPFieldsCount{
                let fieldTag = 100 + i
                if let otpField = self.contentView.viewWithTag(fieldTag) as? OTPField{
                    otpField.txtLbl.text = letters[i]
                }
                i += 1
            }
        }
    }

    func setUpUserFieldDetailsOfUser(_ userInfo : String ,
                                     typeOfTxtField : AuthDataModel.TypeOfCellField ,inputAccessoryView : UIToolbar? , delegate : FloatingTxtFieldDelegate?) -> Void {
        
        OTPtext = userInfo
        dummyTxtField.keyboardType = .numberPad
        dummyTxtField.text = OTPtext
        
        switch typeOfTxtField {
        case .otp:
            
            break
       
            
        default:
            break
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}





extension OTPTextFieldCell:UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isFieldEditing = true
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        isFieldEditing = false

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if updatedText.count <= OTPFieldsCount{
                self.OTPtext = updatedText
                isFieldEditing = true
//                Async.main{if updatedText.count == self.OTPFieldsCount {self.endEditing(true)}
//}
                self.dataModel?.emailAndPhoneInfo.OTP = updatedText
                return true
            }
        }
        return false

    }
    
}
extension UITableViewCell{
    func deactivateCell(_ deactivate : Bool) -> Void {
        if !deactivate {
            self.isUserInteractionEnabled = true
            self.contentView.alpha = 1
        }else{
            self.isUserInteractionEnabled = false
            self.contentView.alpha = 0.5
        }
    }
}
