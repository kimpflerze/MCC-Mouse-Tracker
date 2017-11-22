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
        //Most likely will have to update the date once we have the new server hosted by MCC.
        let formatter = DateFormatter()
        //"Created": "2017-10-26T15:50:24.5",
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if var dateString = parentInfo["DOB"] as? String {
            let index = dateString.index(dateString.startIndex, offsetBy: 19)
            dateString = dateString.substring(to: index)
            dateString = dateString.replacingOccurrences(of: "T", with: " ")
            if let theDob = formatter.date(from: dateString) {
                dob = theDob
            }
        }
    }
    
}
