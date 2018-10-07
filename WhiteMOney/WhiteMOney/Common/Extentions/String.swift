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
