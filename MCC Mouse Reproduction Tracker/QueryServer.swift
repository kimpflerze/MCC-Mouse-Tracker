//
//  QueryServer.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/3/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import Alamofire

class QueryServer: NSObject {
    
    static let shared = QueryServer()
    
    var lastActivityTimeStamp: Date?
    
    func getAllBreedingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingcage") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getAllActiveBreedingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingcage?active=1") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getAllSellingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/sellingcage") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getAllActiveSellingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/sellingcage?active=1") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getAllBreedingMales(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingmale") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getAllActiveBreedingMales(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingmale?active=1") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getAllLitterLogs(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/litterlog") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getSettings(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        //Query the server for the settings and store them in the Settings singleton
    }

    
    
}
