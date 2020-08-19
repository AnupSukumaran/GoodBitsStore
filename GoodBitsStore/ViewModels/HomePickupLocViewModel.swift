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
import SASLoaderPod

class HomePickupLocViewModel: NSObject {
    
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var pickupLocationsModel:PickupLocationsModel?
    var pickUps = [Pickup]()
    var sortedDistancePickUps = [Pickup]()
    var tableReloadHandler: (() -> ())?

    let refreshControl = UIRefreshControl()
    var loader: LoaderView!
    var locHandler: ((_ success: Bool) -> ())?
    var settingHandler: (() -> ())? = {
        
        UIAlertController.removeSASSuperAlert()
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    var cancelHandler: (() -> ())?
    
    override init() {}
    
    init(loader: LoaderView) {
        self.loader = loader
        super.init()
        self.cancelHandler = {
            UIAlertController.removeSASSuperAlert()
            self.locHandler?(false)
        }
        
    }
    
}

extension HomePickupLocViewModel {
    
    /// function to setup refresh controller
    func setUpRefreshController() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    /// Selector funciton upon pull refresh action
    @objc func refreshData() {
        refreshControl.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.callApiPickupLocations()
        }
    }
    
    /// Function that request for authorization to access the user current location and setting up the the best level of accuracy available and also assigned delegate to access the protocol funtions
    func requestLocationAutorization() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    /// This funciton stops and starts updating locations as the use press the location button and also sorts the distance calculated from the current location receieved in assending order. and update the table by calling the tableReloadHandler
    /// - Parameter startLocating: This value is received from the button action to enable user to access the current location.
    func checkUserAutorizedLocation(startLocating: Bool) {
        
      
        if CLLocationManager.authorizationStatus() == .denied {
            UIAlertController.showSuperAlertView(title: "Settings", message: "Allow location from settings", actionTitles: ["OK", "Cancel"], actions: [settingHandler, cancelHandler])
        }
        
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            
            Logger.p("self.locHandler?() = \(self.locHandler)")
            
            self.locHandler?(startLocating)
            
            guard startLocating else {
                currentLoc = nil
                locationManager.stopUpdatingLocation()
                self.tableReloadHandler?()
                return
            }
        
            locationManager.startUpdatingLocation()
            currentLoc = locationManager.location
            let currLat = currentLoc?.coordinate.latitude ?? 0.0
            let currLong = currentLoc?.coordinate.longitude ?? 0.0
            
            let newPickUp = pickUps.map { (pickUp) -> Pickup in
                var newPickUp = pickUp
                if let lat = newPickUp.latitude , let long = newPickUp.longitude {
                    let distance = getDistance(coord1: (lat: currLat, long: currLong), coord2: (lat: lat, long: long))
                    newPickUp.distance = distance
                }
                

               return newPickUp
            }
            
            sortedDistancePickUps = newPickUp.sorted { (x, y) -> Bool in
                guard let xd = x.distance, let yd = y.distance else {return false}
                return xd < yd
            }
            
            self.tableReloadHandler?()
            
        } else {
            
            requestLocationAutorization()
        }
    }
    
    
    /// API Call
    func callApiPickupLocations() {
        loader.startAnimating()
        APILibrary.shared.apiPickupLocations(filterId: "1") { (response) in
            self.loader.stopAnimating()
            
            switch response {
            case.success(let data):
                self.pickupLocationsModel = data.pickupLocationsModel
                if let pickUps = data.pickupLocationsModel?.pickup {
                    self.pickUps = pickUps.filter{$0.active == true}
                    self.pickUps = self.removeDataIfValueNotAvailable(self.pickUps)
                    self.tableReloadHandler?()
                }
                
            case.failure(errorStr: let errStr) :
                UIAlertController.showSuperAlertView(title: .appName, message: errStr.errorStr, actionTitles: ["Ok"], actions: [UIAlertController.removeSASSuperAlert])
        
            }
        }
    }
    
    
    /// Function that removes all the unwanted empty data and filters out the empty values and creates a new collection of array
    /// - Parameter pickUps: the pickup model array values reveived from the api response.
    /// - Returns: Returns a new values of pickup array filtering out the empty values
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
        return currentLoc == nil ? pickUps.count : sortedDistancePickUps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomePickUpLocTableViewCell.identifier, for: indexPath) as? HomePickUpLocTableViewCell {
            
            cell.cellModel = HomePickUpLocCellModel(pickup: currentLoc == nil ? pickUps[indexPath.row] : sortedDistancePickUps[indexPath.row])
            cell.layoutIfNeeded()
        
            return cell
        }
        return UITableViewCell()
    }
    
}

extension HomePickupLocViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            
            checkUserAutorizedLocation(startLocating: true)
            
        case .notDetermined:
            
            break
            
        case .denied:
            
            self.locHandler?(false)
            
        case.restricted:
            
            break
            
        default:
            
            break
        }
    }
    
    
}
