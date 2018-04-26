//
//  ParentCage.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/8/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class ParentCage: NSObject {

    var id = ""
    var parentCageId = ""
    var currentCageId = ""
    var dob: Date?
    
    init(parentInfo: [String : Any]) {
        if let theId = parentInfo["Id"] as? String {
            id = theId
        }
        if let theParentCageId = parentInfo["ParentCageId"] as? String {
            parentCageId = theParentCageId
        }
        if let theCurrentCageId = parentInfo["CurrentCageId"] as? String {
            currentCageId = theCurrentCageId
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
        if let dateString = parentInfo["DOB"] as? String {
            if let theDob = formatter.date(from: dateString) {
                dob = theDob
            }
        }
    }
}
