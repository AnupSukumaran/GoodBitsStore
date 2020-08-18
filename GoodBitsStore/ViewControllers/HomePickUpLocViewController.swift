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
    
    
    var viewModel: HomePickupLocViewModel? {
        didSet {
            setHandlers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locListView.dataSource = viewModel
        locListView.delegate = viewModel
        locListView.estimatedRowHeight = 110
        locListView.rowHeight = UITableView.automaticDimension
        
        viewModel?.setUpRefreshController()
        locListView.refreshControl = viewModel?.refreshControl
        locationBtn.isSelected = false
        
        viewModel?.callApiPickupLocations()
    }
    
    
    @IBAction func locationBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let btnImage = sender.isSelected ? UIImage(named: "locOff") : UIImage(named: "locOn")
        locationBtn.setImage(btnImage, for: .normal)
        viewModel?.checkUserAutorizedLocation(startLocating: sender.isSelected)
    }
    
}


extension HomePickUpLocViewController {
    
    func setHandlers() {
        viewModel?.tableReloadHandler = { [weak self] in
            guard let vc = self else {return}
            
            vc.locListView.reloadData()
        }
       
    }
}
