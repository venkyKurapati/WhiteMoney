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
            

           
            
            
            
            
            
        case .panCardField:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.panCardNumPlaceholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .phonePad, delegate: delegate ,logoImg : nil,isSecureTextEntry : false, warningText: "")
            
            
        case .aadharCardField:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.aadharCardNumPlaceholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false, warningText: "")
        case .currentCompanyName:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.currentCompanyNamePlaceholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .phonePad, delegate: delegate ,logoImg : nil,isSecureTextEntry : false, warningText: "    * This number will recive OTP.")
            
            
        case .monthlyIncome:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.monthlySalaryInHandPlaceholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false, warningText: "")
        case .anualIncome:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.annualIncomePlaceholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .phonePad, delegate: delegate ,logoImg : nil,isSecureTextEntry : false, warningText: "    * This number will recive OTP.")
            
            
        case .addressLine1:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.add1Placeholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false, warningText: "")
            
        case .addressLine2:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.add2Placeholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false, warningText: "")
            
            
        case .cityField:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.cityPlaceholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false, warningText: "")
            
        case .stateField:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.statePlaceholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false, warningText: "")
        case .pinCode:
            floatingTxtView.setUpTxtField(userInfo, font: UIFont.appTextFont(), textColor: UIColor.appPrimaryTextColor(), underLine_Hilight_ViewColor: UIColor.appHilightedTxtColor(), underLineViewColor: UIColor.fieldBackgroundColor(), placeHoleder: Constants.pinCodePlaceholder, placeHolederLblFont: UIFont.appTextFont(), placeholderTxtColor: UIColor.fieldBackgroundColor(), keyboardType: .default, delegate: delegate ,logoImg : nil, isSecureTextEntry : false, warningText: "")
            
            
        default:
            break
        }
        
    }
    
    
}
