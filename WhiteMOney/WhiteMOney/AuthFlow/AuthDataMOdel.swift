//
//  AuthDataMOdel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 06/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation

class AuthDataModel: NSObject {
    
    var emailAndPhoneInfo : EmailAndPhoneVerifyAuthModel
    var eligibilityCheckInfo : EligibilityCheckModel?

    init(_ emailAndPhoneVerifyModel : EmailAndPhoneVerifyAuthModel? ) {
        self.emailAndPhoneInfo = emailAndPhoneVerifyModel ?? EmailAndPhoneVerifyAuthModel()
//        self.eligibilityCheckInfo = eligibilityCheckInfo ?? EligibilityCheckModel()
    }
    
    class EmailAndPhoneVerifyAuthModel {
        var fullName  = ""
        var email  = ""
        var phoneNum  = ""
        var isOTPGenerated = false
        var OTP  = ""
        var isOTPVerified  = false
        var password = ""
    }
    class EligibilityCheckModel {
        var address : AddressModel? = nil
        var employementType : EmployementType = .salaried
        var nameOfCurrentCompany = ""
        var monthlyInHandSalary = ""
        var netAnnualIncome = ""
        var panCardNumber = ""
        var aadharCardNumber = ""
        
    }
    class DocumentsUploadModel {
        
    }
    enum EmployementType : String{
        case salaried = "Salaried"
        case selfEmployed = "SelfEmployed"

    }
    
    
    enum TypeOfCellField : String {
        case email = "Email"
        case phoneNum = "PhoneNum"
        case fullName = "FullName"
        case otp = "OTP"
        case password = "Password"
        case nextBtn = "NextBtn"
        case nextWithCancelOTP = "NextWithCancelOTP"
        case nextWithCancelPassword = "NextWithCancelPassword"
        
        
        case employmentType = "EmploymentTypeField"
        case anualIncome = "AnualIncome"
        case currentCompanyName = "CurrentCompanyName"
        case monthlyIncome = "MonthlyIncome"

        case addAddressField = "addAddressField"
        case showAddressField = "showAddressField"
        
        case panCardField = "PanCardNumberField"
        case aadharCardField = "AadharCardNumberField"
        
        
        case uploadPhoto = "Photo"
        case uploadPanCard = "Pan card"
        case uploadProofOfResidence = "Proof of residence"
        case uploadSalarySlip = "Salary slips"
        case uploadITR = "Income tax return"
        case bankStatements = "Bank statements"
        
    }
    
}




class AddressModel: NSObject {
    var addressLine1 : String = ""
    var addressLine2 : String = ""
    var city : String = ""
    var state : String = ""
    var country : String = ""
    var pinCode : String = ""
}
