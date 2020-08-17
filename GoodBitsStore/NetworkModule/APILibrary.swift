//
//  APILibrary.swift
//  GoodBitsStore
//
//  Created by Sukumar Anup Sukumaran on 17/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import UIKit
import Alamofire
import SASLogger
import APILib

typealias JSON = [String: AnyObject]
typealias OJSON = [String : Any?]

class APILibrary: NSObject {
    
    typealias BaseAPI = (scheme: String, host: String, path: String)
    typealias Header = (headerVal: String, headerKey: String)
    static let shared = APILibrary()
    var apiComponent: BaseAPI = (scheme: .scheme, host: .host, path: .path)
    public let contentType: Header = (headerVal: .kContentType, headerKey: .vAppJson)
    
}

extension APILibrary {
    
    public func apiPickupLocations(filterId: String, comp: @escaping (Results<ModelResponse>) -> ()) {
        let params: OJSON = [.kfilterShop_id: filterId]
        let req = APILib.makeRequest(method: .get, params: params, withHeaders: [contentType], apiComponents: apiComponent, withPathExtension: .pPickupLocations)

        Logger.p("reqURL = \(req.url?.absoluteURL)")

        dataSetter(req, comp: comp)
    }
       
       
    func dataSetter( _ req: URLRequest, cacheSettings: (needToCache: Bool, cacheID: String) = (false, ""), comp: @escaping (Results<ModelResponse>) -> ()) {
       
       AF.request(req).validate().responseJSON { (response) in
           
           Logger.p("API_JData = \(self.printJsonResponse(response.result))")
           
           guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
              comp(.failure(errorStr: response.error!.localizedDescription))
              return
           }
           
           guard let data = response.data else { return }
           
           do {
               let modelResponse = try ModelResponse(data: data)
               comp(.success(modelResponse))
           } catch (let error) {
               comp(.failure(errorStr: error.localizedDescription))
           }
           
       }
    }
       
    /// just to print json response values
    /// - Parameter result: response result type from the Alamofire Framework
    func printJsonResponse(_ result:AFResult<Any>) -> String {

        Logger.p("SASresult = \(result)")

        var jData = ""

        switch result {
        case .success(let data):

            if let jsonData = data as? String {
                jData = "\(jsonData)"
            } else if let jsonData = data as? [JSON] {
                jData = "\(jsonData)"
            } else if let jsonData = data as? JSON {
                jData = "\(jsonData)"
            }else if let jsonData = data as? Bool {
                jData = "\(jsonData)"
            }else {
                jData = "NO DATA FOUND"
            }

        case .failure(let error):
            jData = "ERROR FOUND -> \(error.localizedDescription)"

        }

        return jData

    }
    
}
