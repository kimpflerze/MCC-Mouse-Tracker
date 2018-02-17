//
//  BreedingMale.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/11/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class BreedingMale: NSObject {

    var id = ""
    var motherCageIds = [String]()
    var currentCageId = ""
    var dob: Date?
    var active = false
    
    init(maleInfo: [String : Any]) {
        
        if let theId = maleInfo["Id"] as? String {
            id = theId
        }
        if let theMotherCageId = maleInfo["MotherCageId"] as? String {
            motherCageIds = [theMotherCageId]
        }
        if let theCurrentCageId = maleInfo["CurrentCageId"] as? String {
            currentCageId = theCurrentCageId
        }
        if let theActive = maleInfo["Active"] as? Bool {
            active = theActive
        }
        
        //Most likely will have to update the date once we have the new server hosted by MCC.
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
        if var dateString = maleInfo["DOB"] as? String {
            if let theDOB = formatter.date(from: dateString) {
                dob = theDOB
            }
        }
        
    }
    
}
