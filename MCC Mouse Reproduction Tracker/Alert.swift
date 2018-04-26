//
//  Alert.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/9/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class Alert: NSObject {

    var id = ""
    var alertTypeID = ""
    var alertTypeDescription = ""
    var subjectId = ""
    var alertDate: Date?
    
    init(alertInfo: [String : Any]) {
        if let theId = alertInfo["AlertId"] as? String {
            id = theId
        }
        if let theTypeId = alertInfo["AlertTypeId"] as? Int {
            alertTypeID = String(theTypeId)
        }
        if let theTypeDescription = (alertInfo["AlertType"] as? [String : Any]) {
            if let theAlertDescription = theTypeDescription["Description"] as? String {
                alertTypeDescription = theAlertDescription
            }
        }
        if let theSubjectId = alertInfo["SubjectId"] as? String {
            subjectId = theSubjectId
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
        if let theAlertDate = alertInfo["AlertDate"] as? String {
            if let theFormattedDate = dateFormatter.date(from: theAlertDate) {
                alertDate = theFormattedDate
            }
        }
    }
}
