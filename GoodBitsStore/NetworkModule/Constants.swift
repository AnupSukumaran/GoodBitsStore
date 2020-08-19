//
//  Constants.swift
//  GoodBitsStore
//
//  Created by Sukumar Anup Sukumaran on 17/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import Foundation
import SASLoaderPod

class Const {
    static let loader: (UIViewController) -> (LoaderView) = { (vc) in
        return LoaderView(callOn: vc, type: .ballSpinFadeLoader, color: .black, padding: 18)
    }
    
}

extension String {
    
    static var appName = "GoodBits Store"
    
    static var scheme = "https"
    static var host = "api-staging.pmlo.co"
    static var path = "/v3"
    
    static var pPickupLocations = "/pickup-locations"
    
    static var kfilterShop_id = "filter[shop_id]"
    static let kContentType = "Content-Type"
    
    static let vAppJson = "application/json"
    
    
}


