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
    

    func cellModelConfig() {
        guard let model = cellModel else {return}
        hideLabelsIfNoData(in: model.pickup)
        lbPickAlias.text = model.pickup.alias ?? ""
        lbAddress.text = settingAddresTxt(model.pickup)
        lbCity.text = model.pickup.city ?? ""
        lbKm.text = setDistanceVal(model.pickup)
    }
    
    func setDistanceVal(_ pickUp: Pickup) -> String {
        var dist = ""
        if let d = pickUp.distance {
            dist = d.toDecimalsStr(2) + " km"
        }
        return dist
    }
    
    func hideLabelsIfNoData(in pickUp: Pickup){
        lbPickAlias.isHidden = (pickUp.alias ?? "") == ""
        lbAddress.isHidden = settingAddresTxt(pickUp) == ""
        lbCity.isHidden = (pickUp.city ?? "") == ""
        lbKm.isHidden = pickUp.distance == nil
    }
    
    func settingAddresTxt(_ pickUp: Pickup) -> String {
        let comma = (pickUp.address1 == "") ? "" : ", "
        let add2 = (pickUp.address2 == "") ? "" : (comma + (pickUp.address2 ?? ""))
        return (pickUp.address1 ?? "") + add2
    }
    

}
