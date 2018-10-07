//
//  AuthDataMOdel.swift
//  WhiteMOney
//
//  Created by Venkatesh on 06/10/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import Foundation

class AuthDataModel: NSObject {
    
    var fullName  = "hihi"
    var email  = ""
    var phoneNum  = ""
    var isOTPGenerated = false
    var OTP  = ""
    var isOTPVerified  = false
    var password = ""
    
}


enum TypeOfCellField : String {
    case email = "Email"
    case phoneNum = "PhoneNum"
    case fullName = "FullName"
    case otp = "OTP"
    case password = "Password"
    case nextBtn = "NextBtn"
    case nextWithCancel = "NextWithCancel"
    
}

