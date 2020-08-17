//
//  NSObject+Ext.swift
//  GoodBitsStore
//
//  Created by Sukumar Anup Sukumaran on 17/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var identifier: String {
        String(describing: self)
    }
    
}
