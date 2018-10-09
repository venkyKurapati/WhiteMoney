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

    var OTPFieldsCount = 4
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var OTPtext = ""

    func setUpUserFieldDetailsOfUser(_ userInfo : String ,
                                     typeOfTxtField : TypeOfCellField ,inputAccessoryView : UIToolbar? , delegate : FloatingTxtFieldDelegate?) -> Void {
        
        OTPtext = userInfo
        var letters = userInfo.characters.map { String($0) }

        while letters.count < OTPFieldsCount {
            letters.append("-")
        }
        
        switch typeOfTxtField {
        case .otp:
            
            var i = 0
            while i < OTPFieldsCount{
                let fieldTag = 100 + i
                if let floatingTxtView = self.contentView.viewWithTag(fieldTag) as? FloatingTxtField{
                        floatingTxtView.setUpTxtField(letters[i], font: UIFont.appSectionTextFont(), textColor: UIColor.appHilightedTxtColor(), underLine_Hilight_ViewColor: UIColor.appPrimaryTextColor(), underLineViewColor: UIColor.placeHolderTxtColor(), placeHoleder: "", placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.placeHolderTxtColor(), keyboardType: .phonePad, delegate: self ,logoImg : nil,isSecureTextEntry : false, warningText: "")
                    floatingTxtView.txtField.tintColor = UIColor.clear
                    floatingTxtView.txtField.textAlignment = .center
                }
                i += 1
            }
            
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

extension OTPTextFieldCell: FloatingTxtFieldDelegate {
    func floatingTxtFieldShouldBeginEditing(_ textField: FloatingTxtField) -> Bool {
        let length = OTPtext.count
        if length == OTPFieldsCount {
            if let floaingTxtField = self.contentView.viewWithTag(100+OTPFieldsCount-1) as? FloatingTxtField{
                Async.main{floaingTxtField.makeFirstResponder()}
                if floaingTxtField != textField{return false}

            }
        }else{
            if let floaingTxtField = self.contentView.viewWithTag(100+length) as? FloatingTxtField{
                Async.main{floaingTxtField.makeFirstResponder()}
                if floaingTxtField != textField{return false}

            }
        }
        return true
    }
    
    func floatingTxtField(_ textField: FloatingTxtField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text,let textRange = Range(range, in: text) {
            var updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if updatedText.count == 0{
//                makeFieldRespond()
            }else{
                updatedText = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
                if updatedText.count > 0{
                    OTPtext = OTPtext + updatedText
                }
                makeFieldRespond()
            }


        }
        return true
    }
    
    
//    func floatingTxtField(_ textField: FloatingTxtField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // Range.length == 1 means,clicking backspace
//        if (range.length == 0){
//            let viewTag = textField.tag
//            if viewTag == 100+OTPFieldsCount-1{
//                textField.txtField.resignFirstResponder()
//            }else{
//                if let floatingTxtField = self.contentView.viewWithTag(textField.tag+1) as? FloatingTxtField{
//                    floatingTxtField.txtField.becomeFirstResponder()
//                }
//            }
//            textField.text? = string
//            return false
//        }else if (range.length == 1) {
//            if let floatingTxtField = self.contentView.viewWithTag(textField.tag-1) as? FloatingTxtField{
//                floatingTxtField.txtField.becomeFirstResponder()
//            }
//            textField.text? = ""
//            return false
//        }
//        return true
//    }
    
    
    func makeFieldRespond() -> Void {
        let length = OTPtext.count
        if length == OTPFieldsCount {
            self.resignFirstResponder()
        }else{
            if let floaingTxtField = self.contentView.viewWithTag(100+length) as? FloatingTxtField{
                Async.main{floaingTxtField.makeFirstResponder()}
            }
        }
    }
    func floatingTxtFieldDidEndEditing(_ textField: FloatingTxtField) {
        
    }
    func floatingTxtFieldShouldClear(_ textField: FloatingTxtField) -> Bool {
        return true
    }
    
}
