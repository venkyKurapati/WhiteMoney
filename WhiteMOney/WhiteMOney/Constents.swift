//
//  Constents.swift
//  WhiteMOney
//
//  Created by Venkatesh on 06/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation

struct Constants{
  
    static let emailPlaceHolder = "Email"
    static let phoneNumPlaceHolder = "Phone Number"
    static let OTPPlaceHolder = "OTP"
    static let fullNamePlaceHolder = "Full Name (As per PAN Card)"
    static let passwordPlaceHolder = "Password"
    
    static let panCardNumPlaceholder = "Pan card number"
    static let aadharCardNumPlaceholder = "Aadhar number"
    static let currentCompanyNamePlaceholder = "Current company name"
    static let monthlySalaryInHandPlaceholder = "Monthly salary in-hand"
    static let annualIncomePlaceholder = "Annual income"

    
    
    static let add1Placeholder = "Address line-1"
    static let add2Placeholder = "Address line-2"
    static let cityPlaceholder = "City"
    static let statePlaceholder = "State"
    static let pinCodePlaceholder = "PinCode"


}
let blnkExtensionMsg = "can't be black."
let validEntryPrefix = "Please enter valid "

struct ErrorMessages {
    
    // empty field error msgs
    static let fullNameEmptyErrorMsg = "Full name \(blnkExtensionMsg)"
    static let emailEmptyErrorMsg = "Email \(blnkExtensionMsg)"
    static let phoneNumEmptyErrorMsg = "Phone number \(blnkExtensionMsg)"
    static let passwordEmptyErrorMsg = "Password \(blnkExtensionMsg)"

    static let annualIncomeEmptyErrorMsg = "Annual incom \(blnkExtensionMsg)"
    static let currentCompanyNameEmptyErrorMsg = "Current company name \(blnkExtensionMsg)"
    static let monthlySalaryInHandEmptyErrorMsg = "Monthly salary in-hand \(blnkExtensionMsg)"
    static let panCardNumberEmptyErrorMsg = "Pan card number \(blnkExtensionMsg)"
    static let aadharCardNumberEmptyErrorMsg = "Aadhar card number \(blnkExtensionMsg)"
    static let addressLine1EmptyErrorMsg = "Address line-1 \(blnkExtensionMsg)"
    static let addressLine2EmptyErrorMsg = "Address line-2 \(blnkExtensionMsg)"
    static let cityEmptyErrorMsg = "City \(blnkExtensionMsg)"
    static let stateEmptyErrorMsg = "State \(blnkExtensionMsg)"
    static let pinCodeEmptyErrorMsg = "Pin code \(blnkExtensionMsg)"

    
    
    // invalid field error messsages

    static let emailInvalidErrorMsg = "\(validEntryPrefix) Email."
    static let phoneNumberInvalidErrorMsg = "\(validEntryPrefix) Phone number."

    
    
    
    
}
