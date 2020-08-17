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
    
    var viewModel: HomePickupLocViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locListView.dataSource = viewModel
        locListView.delegate = viewModel
        
        viewModel.callApiPickupLocations()
    }
    
}
