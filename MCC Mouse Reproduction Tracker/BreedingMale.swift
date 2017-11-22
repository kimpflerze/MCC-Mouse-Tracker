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
        //"Created": "2017-10-26T15:50:24.5",
        formatter.dateFormat = "MM/dd/yyyy hh:mm:ss"
        if var dateString = maleInfo["DOB"] as? String {
            let index = dateString.index(dateString.startIndex, offsetBy: 19)
            dateString = dateString.substring(to: index)
            dateString = dateString.replacingOccurrences(of: "T", with: " ")
            if let theDOB = formatter.date(from: dateString) {
                dob = theDOB
            }
        }
        
    }
    
}
