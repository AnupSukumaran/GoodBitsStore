//
//  HomePickUpLocViewController.swift
//  GoodBitsStore
//
//  Created by Sukumar Anup Sukumaran on 17/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import UIKit


class HomePickUpLocViewController: UIViewController {
    
    
    @IBOutlet weak var locListView: UITableView!
    @IBOutlet weak var locationBtn: UIButton!
    
    var viewModel: HomePickupLocViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locListView.dataSource = viewModel
        locListView.delegate = viewModel
        
        viewModel.callApiPickupLocations()
    }
    
    
    @IBAction func locationBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let btnImage = sender.isSelected ? UIImage(named: "locOff") : UIImage(named: "locOn")
        locationBtn.setImage(btnImage, for: .normal)
    }
    
}
