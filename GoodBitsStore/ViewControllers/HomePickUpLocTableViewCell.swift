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
    
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    var cellModel: HomePickUpLocCellModel? {
        didSet {
            cellModelConfig()
        }
    }
    
//    var currentLoc: CLLocation? {
//        didSet {
//            getDistancevalue()
//        }
//    }
    
//    override class func awakeFromNib() {
//
//        super.awakeFromNib()
//
//    }
//
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
    
//    func getDistancevalue() {
//        guard let d = currentLoc else {lbKm.isHidden = true;return}
//        lbKm.isHidden = false
//        guard let lat = cellModel?.pickup.latitude , let long = cellModel?.pickup.longitude else {return}
//        let distance = getDistance(coord1: (lat: d.coordinate.latitude, long: d.coordinate.longitude), coord2: (lat: lat, long: long)).toDecimalsStr(2)
//        lbKm.text = distance + "km"
//    }
    
//    override func layoutIfNeeded() {
//        super.layoutIfNeeded()
//        clipsToBounds = false
//        contentView.clipsToBounds = false
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//      //  contentView.clipsToBounds = true
//        clipsToBounds = false
//        contentView.clipsToBounds = false
//    }
//
//
//    override func prepareForReuse() {
//      //  contentView.clipsToBounds = true
//        clipsToBounds = false
//        contentView.clipsToBounds = false
//        lbPickAlias.text = ""
//        lbAddress.text = ""
//        lbCity.text = ""
//        lbKm.text = ""
//    }
    

}
