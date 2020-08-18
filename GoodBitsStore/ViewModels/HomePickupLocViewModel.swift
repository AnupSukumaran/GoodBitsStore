//
//  HomePickupLocViewModel.swift
//  GoodBitsStore
//
//  Created by Sukumar Anup Sukumaran on 17/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import UIKit
import SASLogger
import CoreLocation

class HomePickupLocViewModel: NSObject {
    
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var pickupLocationsModel:PickupLocationsModel?
    var pickUps = [Pickup]()
    var sortedPickUps = [Pickup]()
    var tableReloadHandler: (() -> ())?
    
    override init() {}
    
}

extension HomePickupLocViewModel {
    
    func requestLocationAutorization() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //kCLLocationAccuracyNearestTenMeters//kCLLocationAccuracyKilometer
    }
    
    func checkUserAutorizedLocation(startLocating: Bool) {
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            
            guard startLocating else {
                currentLoc = nil
                locationManager.stopUpdatingLocation()
                self.tableReloadHandler?()
                return
            }
        
            locationManager.startUpdatingLocation()
            currentLoc = locationManager.location
            let lat = currentLoc?.coordinate.latitude ?? 0.0
            let long = currentLoc?.coordinate.longitude ?? 0.0
            
            Logger.p("SASlat = \(lat)")
            Logger.p("SASlong = \(long)")
            self.tableReloadHandler?()
            
        } else {
            requestLocationAutorization()
        }
    }
    
    func callApiPickupLocations() {
        
        APILibrary.shared.apiPickupLocations(filterId: "1") { (response) in
            switch response {
            case.success(let data):
                self.pickupLocationsModel = data.pickupLocationsModel
                if let pickUps = data.pickupLocationsModel?.pickup {
                    self.pickUps = pickUps.filter{$0.active == true}
                    Logger.p("pickUps1 = \(self.pickUps.count)")
                    self.pickUps = self.removeDataIfValueNotAvailable(self.pickUps)
                    Logger.p("pickUps2 = \(self.pickUps.count)")
                    self.tableReloadHandler?()
                }
                
            case.failure(errorStr: let errStr) :
                UIAlertController.showSuperAlertView(title: .appName, message: errStr.errorStr, actionTitles: ["Ok"], actions: nil)
                Logger.p("errStr = \(errStr)")
            }
        }
    }
    
    func removeDataIfValueNotAvailable(_ pickUps: [Pickup]) -> [Pickup] {
        return pickUps.filter({ (pickUpsModel) -> Bool in
            if (pickUpsModel.alias ?? "") == "" && (pickUpsModel.address1 ?? "") == "" && (pickUpsModel.address2 ?? "") == "" && (pickUpsModel.city ?? "") == "" {
                return false
            }
            return true
        })
    }
    
}

extension HomePickupLocViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickUps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomePickUpLocTableViewCell.identifier, for: indexPath) as? HomePickUpLocTableViewCell {
            
            cell.cellModel = HomePickUpLocCellModel(pickup: pickUps[indexPath.row])
            cell.currentLoc = currentLoc
            cell.layoutIfNeeded()
            return cell
        }
        return UITableViewCell()
    }

}

extension HomePickupLocViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        Logger.p("status = \(status.rawValue)")
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            checkUserAutorizedLocation(startLocating: true)
        
        default:
            break
        }
    }
    
    
}
