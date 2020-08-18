//
//  HomePickUpLocTableViewCell.swift
//  GoodBitsStore
//
//  Created by Sukumar Anup Sukumaran on 18/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import UIKit
import SASLogger
import CoreLocation

class HomePickUpLocTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbPickAlias: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbKm: UILabel!
    
    var cellModel: HomePickUpLocCellModel? {
        didSet {
            cellModelConfig()
        }
    }
    
    var currentLoc: CLLocation? {
        didSet {
            getDistancevalue()
        }
    }
    
    func cellModelConfig() {
        guard let model = cellModel else {return}
        lbPickAlias.text = model.pickup.alias ?? ""
        Logger.p("model.pickup.address2- \(model.pickup.address2 ?? "NO data")")
        let comma = (model.pickup.address1 == "") ? "" : ", "
        let add2 = (model.pickup.address2 == "") ? "" : (comma + (model.pickup.address2 ?? ""))
        lbAddress.text = (model.pickup.address1 ?? "") + add2
        lbCity.text = model.pickup.city ?? ""
        if let d = model.pickup.distance {
            lbKm.isHidden = false
            lbKm.text = d.toDecimalsStr(2) + " km"
        } else {
            lbKm.isHidden = true
        }
    }
    
    func getDistancevalue() {
        guard let d = currentLoc else {lbKm.isHidden = true;return}
        lbKm.isHidden = false
        guard let lat = cellModel?.pickup.latitude , let long = cellModel?.pickup.longitude else {return}
        let distance = getDistance(coord1: (lat: d.coordinate.latitude, long: d.coordinate.longitude), coord2: (lat: lat, long: long)).toDecimalsStr(2)
        lbKm.text = distance + "km"
    }

    

}
