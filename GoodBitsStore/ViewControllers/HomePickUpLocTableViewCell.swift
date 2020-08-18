//
//  HomePickUpLocTableViewCell.swift
//  GoodBitsStore
//
//  Created by Sukumar Anup Sukumaran on 18/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import UIKit

class HomePickUpLocTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbPickAlias: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbKm: UILabel!
    
    var cellModel: HomePickUpLocCellModel? {
        didSet {
            
            guard let model = cellModel else {return}
            lbPickAlias.text = model.pickup.alias ?? "-"
            lbAddress.text = (model.pickup.address1 ?? "") + "\n" + (model.pickup.address2 ?? "")
            lbCity.text = model.pickup.city ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
