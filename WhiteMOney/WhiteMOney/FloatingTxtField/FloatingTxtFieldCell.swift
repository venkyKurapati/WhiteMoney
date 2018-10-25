//
//  FloatingTxtFieldCell.swift
//  DesignWithAnchors
//
//  Created by Venkatesh on 05/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

class FloatingTxtFieldCell: UITableViewCell {
    
    @IBOutlet weak var floatingTxtView: FloatingTxtField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUpUserFieldDetailsOfUser(_ userInfo : String ,
                                     typeOfTxtField : AuthDataModel.TypeOfCellField ,inputAccessoryView : UIToolbar? , delegate : FloatingTxtFieldDelegate?) -> Void {
        
        switch typeOfTxtField {
        case .email:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.emailPlaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .emailAddress, delegate: delegate ,logoImg : nil,isSecureTextEntry : false, warningText: "    * This email will get verification link.")
        case .fullName:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.fullNamePlaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .default, delegate: delegate ,logoImg : nil,isSecureTextEntry : false, warningText: "    * Full name as in Pan Card.")
            
        case .phoneNum:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.phoneNumPlaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .phonePad, delegate: delegate ,logoImg : nil,isSecureTextEntry : false, warningText: "    * This number will recive OTP.")
        case .otp:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.OTPPlaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .phonePad, delegate: delegate ,logoImg : nil,isSecureTextEntry : false, warningText: "    * This number will recive OTP.")

            
        case .password:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.passwordPlaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : true, warningText: "")
            
//
//        case .zipCode:
//            floatingTxtView.setUpTxtField(userInfo, inputAccessoryView: inputAccessoryView, font: UIFont.appTextFont(), textColor: UIColor.appHilightedTxtColor(), underLine_Hilight_ViewColor: UIColor.appPrimaryTextColor(), underLineViewColor: UIColor.placeHolderTxtColor(), placeHoleder: Constants.zipCodeTxtPLaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.placeHolderTxtColor(), keyboardType: .numbersAndPunctuation, delegate: delegate ,logoImg : nil, isSecureTextEntry : false)
//
//        case .state:
//            floatingTxtView.setUpTxtField(userInfo, inputAccessoryView: inputAccessoryView, font: UIFont.appTextFont(), textColor: UIColor.appHilightedTxtColor(), underLine_Hilight_ViewColor: UIColor.appPrimaryTextColor(), underLineViewColor: UIColor.placeHolderTxtColor(), placeHoleder: Constants.stateTxtPLaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.placeHolderTxtColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false)
//        case .city:
//            floatingTxtView.setUpTxtField(userInfo, inputAccessoryView: inputAccessoryView, font: UIFont.appTextFont(), textColor: UIColor.appHilightedTxtColor(), underLine_Hilight_ViewColor: UIColor.appPrimaryTextColor(), underLineViewColor: UIColor.placeHolderTxtColor(), placeHoleder: Constants.cityTxtPLaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.placeHolderTxtColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false)
//        case .startDate:
//            floatingTxtView.setUpTxtField(userInfo, inputAccessoryView: inputAccessoryView, font: UIFont.appTextFont(), textColor: UIColor.appHilightedTxtColor(), underLine_Hilight_ViewColor: UIColor.appPrimaryTextColor(), underLineViewColor: UIColor.placeHolderTxtColor(), placeHoleder: Constants.startDateTxtPLaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.placeHolderTxtColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false)
//        case .endDate:
//            floatingTxtView.setUpTxtField(userInfo, inputAccessoryView: inputAccessoryView, font: UIFont.appTextFont(), textColor: UIColor.appHilightedTxtColor(), underLine_Hilight_ViewColor: UIColor.appPrimaryTextColor(), underLineViewColor: UIColor.placeHolderTxtColor(), placeHoleder: Constants.endDateTxtPLaceHolder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.placeHolderTxtColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false)
            
            
        default:
            break
        }
        
    }
    
    
}
