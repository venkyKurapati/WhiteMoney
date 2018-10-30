//
//  String.swift
//  WhiteMoney Support
//
//  Created by bogdan on 2018-04-05.
//  Copyright © 2018 WhiteMoney, Inc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func attributed(accents: [String?]? = []) -> NSAttributedString {
        let baseAttributes = [NSAttributedStringKey.strokeColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        let accentAttributes = [NSAttributedStringKey.foregroundColor: UIColor.appDarkBlue, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)]
        let attributedText =  NSMutableAttributedString(string: self, attributes: baseAttributes)
        
        if let accents = accents {
            for accent in accents {
                if let accent = accent, let substringRange = self.range(of: accent) {
                    let nsRange = NSRange(substringRange, in: self)
                    attributedText.addAttributes(accentAttributes, range: nsRange)
                }
            }
        }
        
        return attributedText
    }
    func formateDateString() -> Date? {
//        if var components = dateStr_WhiteMoney?.components(separatedBy: " "){
//            var dateStr = components[0]
//            dateStr = String(dateStr.reversed())
//            components[0] = dateStr
//            return components.joined(separator: " ")
//        }
//        return ""
//
        
        let parsingDF = DateFormatter()
        parsingDF.dateFormat = "MM-dd-yyyy HH:mm:ss" // TODO: pasar al servicio
        
//        let showDF = DateFormatter()
//        showDF.dateFormat = "EEE, MM-dd-yyyy HH:mm a"
        
        let date = parsingDF.date(from: self)
        return date
        
    }
    
    
    
}





// Validators
extension String{
    func isValidEmail() -> Bool {
        print("validate emilId: \(self)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
}
