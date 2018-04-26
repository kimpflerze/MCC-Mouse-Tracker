//
//  LitterLog.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 2/24/18.
//  Copyright © 2018 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class LitterLog: NSObject {
    
    var id = ""
    var motherCageId = ""
    var fatherId = ""
    var dob : Date?
    
    init(logInfo: [String : Any]) {
        if let theId = logInfo["Id"] as? String {
            id = theId
        }
        if let theMotherCageId = logInfo["MotherCageId"] as? String {
            motherCageId = theMotherCageId
        }
        if let theFatherId = logInfo["FatherId"] as? String {
            fatherId = theFatherId
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
        if var dateString = logInfo["DOB"] as? String {
            if let theDOB = formatter.date(from: dateString) {
                dob = theDOB
            }
        }
    }
}
