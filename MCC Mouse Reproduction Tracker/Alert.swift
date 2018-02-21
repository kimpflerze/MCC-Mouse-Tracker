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
        if let theId = alertInfo["Id"] as? String {
            id = theId
        }
        if let theTypeId = (alertInfo["AlertType"] as? [String : Any])?["Id"] as? Int {
            alertTypeID = String(theTypeId)
        }
        if let theTypeDescription = (alertInfo["AlertType"] as? [String : Any])?["Description"] as? String {
            alertTypeDescription = theTypeDescription
        }
        if let theSubjectId = alertInfo["SubjectId"] as? String {
            subjectId = theSubjectId
        }
        print("[TO-DO] Come back and fix this date information in Alert.swift")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
