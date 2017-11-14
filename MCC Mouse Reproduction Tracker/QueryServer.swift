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
    
    func getAllBreedingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "http://private-anon-b7d5b0f84e-mouseapi.apiary-mock.com/api/breedingcages/id") else {
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

    
    
}
