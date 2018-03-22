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
    var userName = "Username"
    var email = "email"
    
    //Rack information
    var numRacks : Int?
    var numColumns : Int?
    var numRows : Int?
    //Mouse breeding/lifetime information
    var weaningPeriodNumber : Int?
    var weaningPeriodUnit : Int?
    
    var breedingPeriodNumber : Int?
    var breedingPeriodUnit : Int?
    
    var gestationPeriodNumber : Int?
    var gestationPeriodUnit : Int?
    
    var maleLifeSpanNumber : Int?
    var maleLifeSpanUnit : Int?
    
    var femaleLifeSpanNumber : Int?
    var femaleLifeSpanUnit : Int?
    
    //Financial information
    var costPerMaleMouse : Double?
    var costPerFemaleMouse : Double?
    var costPerCagePerDay : Double?
    
    //Alert color settings
    var maleInCageAlertIcon : UIImage?
    var pupsInCageAlertIcon : UIImage?
    var pupsToWeanAlertIcon : UIImage?
    var maleTooOldAlertIcon : UIImage?
    var femaleTooOldAlertIcon: UIImage?
    var cageWithOrderAlertIcon : UIImage?
    
    //Alert advance settings
    var maleInCageAlertAdvanceNumber : Int?
    var maleInCageAlertAdvanceUnit : Int?
    
    var pupsInCageAlertAdvanceNumber : Int?
    var pupsInCageAlertAdvanceUnit : Int?
    
    var pupsToWeanAlertAdvanceNumber : Int?
    var pupsToWeanAlertAdvanceUnit : Int?
    
    var maleTooOldAlertAdvanceNumber : Int?
    var maleTooOldAlertAdvanceUnit : Int?
    
    var femaleTooOldAlertAdvanceNumber : Int?
    var femaleTooOldAlertAdvanceUnit : Int?
    
    var cageWithOrderAdvanceAlertNumber : Int?
    var cageWithOrderAdvanceAlertUnit : Int?
    
    //MCC color for use when programming
    let masseyCancerCenterYellow = UIColor(red: 0.949, green: 0.753, blue: 0.055, alpha: 1.0)

    
}
