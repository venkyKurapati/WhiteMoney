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
    var documentsInfo : DocumentsUploadModel?

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
        var address = AddressModel()
        var employementType : EmployementType = .salaried
        var nameOfCurrentCompany = ""
        var monthlyInHandSalary = ""
        var netAnnualIncome = ""
        var panCardNumber = ""
        var aadharCardNumber = ""
        
    }
    class DocumentsUploadModel {
        var uploadedPhotoData : Data?
        var uploadedPanCard : Data?
        var uploadedProofOfResidence : Data?
        var uploadedSalarySlip : Data?
        var uploadedITR : Data?
        var bankStatements : Data?

        
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
        case nextWithCancel = "NextWithCancel"
      
        
        case panCardField = "PanCardNumberField"
        case aadharCardField = "AadharCardNumberField"
        
        case addressLine1 = "AddressLine1Field"
        case addressLine2 = "AddressLine2Field"
        case cityField = "CityField"
        case stateField = "StateField"
        case pinCode = "PinCode"
        
        case employmentType = "EmploymentTypeField"
        case currentCompanyName = "CurrentCompanyName"
        case monthlyIncome = "MonthlyIncome"
        case anualIncome = "AnualIncome"

        
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
