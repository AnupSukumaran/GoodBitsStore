//
//  ModelResponse.swift
//  
//
//  Created by Manu Puthoor on 10/03/20.
//

import Foundation
import UIKit
import SASLogger

public class ModelResponse: NSObject, Codable {
    
    var pickupLocationsModel:PickupLocationsModel?
    
    public init(data: Data) throws {
        super.init()
        pickupLocationsModel = try? JSONDecoder().decode(PickupLocationsModel.self, from: data)
    }
    
    

    
   
}
