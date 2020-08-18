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
    var tableReloadHandler: (() -> ())?
    
    override init() {
        
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        //userAllowedToUseLocation()
    }
    
}

extension HomePickupLocViewModel {
    
    func userAllowedToUseLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
           currentLoc = locationManager.location
            let lat = currentLoc?.coordinate.latitude ?? 0.0
            let long = currentLoc?.coordinate.longitude ?? 0.0
            
            Logger.p("SASlat = \(lat)")
            Logger.p("SASlong = \(long)")
            //9.981391906738281, 76.30953697494819
            //9.992127, 76.301905
            
            let stopPoint = CLLocation(latitude: 9.992127, longitude: 76.301905)
            //let distance = currentLoc!.distance(from: stopPoint)
            let distance = getDistance(coord1: (lat: 9.981391906738281, long: 76.30953697494819), coord2: (lat: 9.992127, long: 76.301905))
            Logger.p("SASdistance = \(distance)") // 1449.0911580976506
        } else {
            
        }
    }
    
    func callApiPickupLocations() {
        
        APILibrary.shared.apiPickupLocations(filterId: "1") { (response) in
            switch response {
            case.success(let data):
                self.pickupLocationsModel = data.pickupLocationsModel
                if let pickUps = data.pickupLocationsModel?.pickup {
                    self.pickUps = pickUps.filter{$0.active == true}
                    self.tableReloadHandler?()
                }
                
            case.failure(errorStr: let errStr) :
                UIAlertController.showSuperAlertView(title: .appName, message: errStr.errorStr, actionTitles: ["Ok"], actions: nil)
                Logger.p("errStr = \(errStr)")
            }
        }
    }
    
}

extension HomePickupLocViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickupLocationsModel?.pickup?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension HomePickupLocViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        Logger.p("status = \(status.rawValue)")
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            
            userAllowedToUseLocation()
    
       
        default:
            
            break
        }
    }
    
    
}