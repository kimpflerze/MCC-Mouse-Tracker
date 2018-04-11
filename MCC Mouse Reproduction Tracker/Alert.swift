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
        if let theTypeId = (alertInfo["AlertTypeId"] as? [String : Any])?["Id"] as? Int {
            alertTypeID = String(theTypeId)
        }
        if let theTypeDescription = (alertInfo["AlertType"] as? [String : Any])?["Description"] as? String {
            alertTypeDescription = theTypeDescription
        }
        if let theSubjectId = alertInfo["SubjectId"] as? String {
            subjectId = theSubjectId
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
        if var theAlertDate = alertInfo["AlertDate"] as? String {
            let dateIndex = theAlertDate.index(theAlertDate.startIndex, offsetBy: 19)
            theAlertDate = theAlertDate.substring(to: dateIndex)
            theAlertDate = theAlertDate.replacingOccurrences(of: "T", with: " ")
            if let theFormattedAlertDate = formatter.date(from: theAlertDate) {
                alertDate = theFormattedAlertDate
            }
            
        }
        
    }
    
}
