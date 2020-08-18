//
//  HomePickUpLocCellModel.swift
//  GoodBitsStore
//
//  Created by Sukumar Anup Sukumaran on 18/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import UIKit

class HomePickUpLocCellModel {

    var pickAlias: String
    var address: String
    var city: String
    
    init(pickAlias: String, address: String, city:String) {
        self.pickAlias = pickAlias
        self.address = address
        self.city = city
    }
}
