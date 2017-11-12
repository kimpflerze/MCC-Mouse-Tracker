//
//  Settings.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/5/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class Settings: NSObject {

    static let shared = Settings()
    
    //Any settings that the app will pull from the database go here, initialize them below
    var userName = "username"
    var email = "password"
    
    var numRacks : Int?
    var numColumns : Int?
    var numRows : Int?
    var weaningPeriod : Date?
    var breedingPeriod : Date?
    var gestationPeriod : Int?
    var maleLifeSpan : Int?
    var femaleLifeSpan : Int?
    var costPerMaleMouse : Double?
    var costPerFemaleMouse : Double?
    var costPerCagePerDay : Double?
    
    let masseyCancerCenterYellow = UIColor(red: 0.949, green: 0.753, blue: 0.055, alpha: 1.0)

    
}
