//
//  Rack.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/3/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class Rack: NSObject {
    
    var id: String?
    var createdAt: Date?
    var row: Int?
    var rack: Int?
    var column: Int?
    var isActive = false
    var parentCageIds = [String]()
    
    init(rackInfo: [String : Any]) {
        id = rackInfo["Id"] as? String
        let genericCage = rackInfo["GenericCage"] as? [String : Any]
    
        let formatter = DateFormatter()
        //"Created": "2017-10-26T15:50:24.5",
        formatter.dateFormat = "yyyy-MM-ddThh:mm:ss.S"
        if let dateString = genericCage?["Created"] as? String {
            createdAt = formatter.date(from: dateString)
        }
        row = genericCage?["Row"] as? Int
        column = genericCage?["Column"] as? Int
        rack = genericCage?["Rack"] as? Int
        if let active = genericCage?["Active"] as? Bool {
            isActive  = active
        }
        if let parentCages = genericCage?["ParentCages"] as? [[String : Any]] {
            for parentCage in parentCages {
                if let parentId = parentCage["Id"] as? String {
                    parentCageIds.append(parentId)
                }
            }
        }
    }

}
