//
//  Rack.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/3/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class Cage: NSObject {
    
    //Generic Cage attributes
    var id = ""
    var createdAt = Date()
    var row = -1
    var rack = -1
    var column = -1
    var isActive = false
    var parentCages = [ParentCage]()
    
    // Selling specific attributes
    var isMaleOnlyCage: Bool?
    var numMice = 0
    var markedForOrder = false
    
    //Breeding specific attributes
    var litterDOB: Date?
    var numLittersFromCage = 0
    var litterInCage = false
    
    //Alert specific attributes - Replaced by alerts being returned in cage JSON in array format
    var alerts = [Alert]() // Should this be optional or initialized?
    
    var needsToBeWeaned = false
    var mouseTooOld = false
    var maleInCage = false
    
    //Attribute specific to the application for navigation purposes
    var isBreeding = false
    
    //Attributes for filter functionality
    var shouldHighlightCage = false
    
    init(rackInfo: [String : Any]) {
        if let theId = rackInfo["Id"] as? String {
            id = theId
        }
        
        //Read in generic cage information
        let genericCage = rackInfo["GenericCage"] as? [String : Any]
    
        //Most likely will have to update the date once we have the new server hosted by MCC.
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
        if var dateString = genericCage?["Created"] as? String {
            if let theCreatedAt = formatter.date(from: dateString) {
                createdAt = theCreatedAt
            }
        }
//        let formatter = DateFormatter()
//        //"Created": "2017-10-26T15:50:24.5",
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss a"
//        if var dateString = genericCage?["Created"] as? String {
//            let index = dateString.index(dateString.startIndex, offsetBy: 19)
//            dateString = dateString.substring(to: index)
//            dateString = dateString.replacingOccurrences(of: "T", with: " ")
//            if let theCreatedAt = formatter.date(from: dateString) {
//                createdAt = theCreatedAt
//            }
//        }
        if let theRow = genericCage?["Row"] as? Int {
            row = theRow
        }
        if let theColumn = genericCage?["Column"] as? Int {
            column = theColumn
        }
        if let theRack = genericCage?["Rack"] as? Int {
            rack = theRack
        }
        if let active = genericCage?["Active"] as? Bool {
            isActive  = active
        }
        if let theParentCages = genericCage?["ParentCages"] as? [[String : Any]] {
            for parentCage in theParentCages {
                let parent = ParentCage(parentInfo: parentCage)
                
                parentCages.append(parent)
            }
        }
        
        //Read in cage type specific information
        if let maleOnlyCage = rackInfo["Gender"] as? Bool {
            isMaleOnlyCage = maleOnlyCage
        }
        if let theMarkedForOrder = rackInfo["MarkedForOrder"] as? Bool {
            markedForOrder = theMarkedForOrder
        }
        if let theNumMiceInCage = rackInfo["NumberOfMice"] as? Int {
            numMice = theNumMiceInCage
        }
        
        if var litterDateString = rackInfo["LitterDOB"] as? String {
            let litterIndex = litterDateString.index(litterDateString.startIndex, offsetBy: 19)
            litterDateString = litterDateString.substring(to: litterIndex)
            litterDateString = litterDateString.replacingOccurrences(of: "T", with: " ")
            if let theLitterDOB = formatter.date(from: litterDateString) {
                //Seems that the server is returning boolean value when it should be a date!
                
                litterDOB = theLitterDOB
            }
        }
        if let theNumLittersFromCage  = rackInfo["LittersFromCage"] as? Int{
            numLittersFromCage = theNumLittersFromCage
        }
        
        if let theAlerts = rackInfo["Alerts"] as? [[String : Any]] {
            for alert in theAlerts {
                let temporaryAlert = Alert(alertInfo: alert)
//                debugPrint(temporaryAlert.id)
                alerts.append(temporaryAlert)
            }
        }
    }

    
}
