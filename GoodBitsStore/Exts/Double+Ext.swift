//
//  Double+Ext.swift
//  GoodBitsStore
//
//  Created by Manu Puthoor on 18/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import Foundation

public extension Double {
    
    /// Double To String Convertor with number of decimel points defined as parameter
    /// - Returns: Returns a string with decimal point
    func toDecimalsStr(_ decimalPointsRequired: Int = 2) -> String {
        return String(format: "%.\(decimalPointsRequired)f", ceil(self*100)/100)
    }
    
    func meterToKm() -> Double {
        return self / 1000
    }
}
