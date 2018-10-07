//
//  Date.swift
//  WhiteMoney2
//
//  Created by Venkatesh on 10/08/18.
//  Copyright © 2018 Leandro Linardos. All rights reserved.
//

import Foundation

enum TimeParams{
    case Sec , Min , Hour
}

extension Date{
    
    func getTimeDifferenceWith(_ date : Date, inParam: TimeParams) -> Double {
        let secondsBetweenDates = self.timeIntervalSince(date)
        switch inParam {
        case .Min:
            return secondsBetweenDates/60
        default:
          return secondsBetweenDates
        }
    }
  
    
    
    
}
