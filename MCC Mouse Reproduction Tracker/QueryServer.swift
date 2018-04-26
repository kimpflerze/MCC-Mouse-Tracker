//
//  QueryServer.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/3/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import Alamofire

class QueryServer: NSObject {
    
    static let shared = QueryServer()
    
    //Timestamp referenced to determine if the current user should be timed out - User timeout not implemented because login was not implemented!
    var lastActivityTimeStamp: Date?
    
    //URLs here so that they're all in one place and easier to change.
    let getAllBreedingCagesURL = "https://mouseapi.azurewebsites.net/api/breedingcage"
    let getAllActiveBreedingCagesURL = "https://mouseapi.azurewebsites.net/api/breedingcage?active=1"
    let getBreedingCageByIDURL = "https://mouseapi.azurewebsites.net/api/breedingcage/"
    let getAllSellingCagesURL = "https://mouseapi.azurewebsites.net/api/sellingcage"
    let getAllActiveSellingCagesURL = "https://mouseapi.azurewebsites.net/api/sellingcage?active=1"
    let getSellingCageByIDURL = "https://mouseapi.azurewebsites.net/api/sellingcage/"
    let getAllBreedingMalesURL = "https://mouseapi.azurewebsites.net/api/breedingmale"
    let getAllActiveBreedingMalesURL = "https://mouseapi.azurewebsites.net/api/breedingmale?active=1"
    let getBreedingMaleByIDURL = "https://mouseapi.azurewebsites.net/api/breedingmale/"
    let getBreedingMaleByCageIDURL = "https://mouseapi.azurewebsites.net/api/breedingmale?currentCageId="
    let getAllLitterLogsURL = "https://mouseapi.azurewebsites.net/api/litterlog/"
    let getLitterLogByIDURL = "https://mouseapi.azurewebsites.net/api/litterlog/"
    let getAlertsURL = "https://mouseapi.azurewebsites.net/api/alert"
    let getSettingsURL = "https://mouseapi.azurewebsites.net/api/settings/1"
    let createNewBreedingCageURL = "https://mouseapi.azurewebsites.net/api/breedingcage"
    let createNewSellingCageURL = "https://mouseapi.azurewebsites.net/api/sellingcage"
    let createNewBreedingMaleURL = "https://mouseapi.azurewebsites.net/api/breedingmale"
    let createLitterLogEntryURL = "https://mouseapi.azurewebsites.net/api/litterlog"
    let updateBreedingCageWithIDURL = "https://mouseapi.azurewebsites.net/api/breedingcage/"
    let updateSellingCageWithIDURL = "https://mouseapi.azurewebsites.net/api/sellingcage/"
    let updateSellingCageDOBWithIDURL = "https://mouseapi.azurewebsites.net/api/breedingfemale"
    let updateBreedingMaleWithIDURL = "https://mouseapi.azurewebsites.net/api/breedingmale/"
    //Reason for the "1" after settings is, the table within the database had to be specified, therefore the "1"
    //indicates the 1 and only entry into the settings table.
    let updateSettingsURL = "https://mouseapi.azurewebsites.net/api/settings/1"
    
//GET Queries
    //Breeding cages queries
    func getAllBreedingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: getAllBreedingCagesURL) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cage.isBreeding = true
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getAllActiveBreedingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: getAllActiveBreedingCagesURL) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    
                    if(cage.alerts.count > 0) {
                        for alert in cage.alerts {
//                            print(alert)
                        }
                    }
                    
                    cage.isBreeding = true
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getBreedingCageBy(id: String, completion: @escaping (_ cage: Cage?, _ error: Error?) -> Void) {
        guard let url = URL(string: getBreedingCageByIDURL+id) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [String : Any] {
                var cage = Cage(rackInfo: result)
                cage.isBreeding = true
                completion(cage, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
    }
    
    
    //Selling cage queries
    func getAllSellingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: getAllSellingCagesURL) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cage.isBreeding = false
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getAllActiveSellingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: getAllActiveSellingCagesURL) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)

                    cage.isBreeding = false
                    cages.append(cage)
                }
                
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getSellingCageBy(id: String, completion: @escaping (_ cage: Cage?, _ error: Error?) -> Void) {
        guard let url = URL(string: getSellingCageByIDURL+id) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [String : Any] {
                let cage = Cage(rackInfo: result)
                cage.isBreeding = false
                completion(cage, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
    }
    
    
    //Breeding male queries
    func getAllBreedingMales(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: getAllBreedingMalesURL) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cages = [Cage]()
                for item in result {
                    let cage = Cage(rackInfo: item)
                    cages.append(cage)
                }
                completion(cages, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getAllActiveBreedingMales(completion: @escaping (_ cages: [BreedingMale]?, _ error: Error?) -> Void) {
        guard let url = URL(string: getAllActiveBreedingMalesURL) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                
                var males = [BreedingMale]()
                for item in result {
                    let male = BreedingMale(maleInfo: item)
                    males.append(male)
                }
                completion(males, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getBreedingMaleBy(id: String, completion: @escaping (_ cage: BreedingMale?, _ error: Error?) -> Void) {
        guard let url = URL(string: getBreedingMaleByIDURL+id) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [String : Any] {
                let male = BreedingMale(maleInfo: result)
                completion(male, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
    }
    
    func getBreedingMaleBy(cageId: String, completion: @escaping (_ cage: BreedingMale?, _ error: Error?) -> Void) {
        guard let url = URL(string: getBreedingMaleByCageIDURL+cageId) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var male: BreedingMale?
                for item in result {
                    male = BreedingMale(maleInfo: item)
                }
                completion(male, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
    }
    
    
    //Litter log queries
    func getAllLitterLogs(completion: @escaping (_ litterLog: [LitterLog]?, _ error: Error?) -> Void) {
        guard let url = URL(string: getAllLitterLogsURL) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            print("=====getAllLitterLogsResponse=====")
            debugPrint(response)
            print("==================================")
            if let result = response.value as? [[String : Any]] {
                var litterLogs = [LitterLog]()
                for item in result {
                    let litter = LitterLog(logInfo: item)
                    litterLogs.append(litter)
                }
                completion(litterLogs, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }
    
    func getLitterLogBy(id: String, completion: @escaping (_ log: LitterLog?, _ error: Error?) -> Void) {
        guard let url = URL(string: getLitterLogByIDURL+id) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [String : Any] {
                let litter = LitterLog(logInfo: result)
                completion(litter, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
    }
    
    //Alerts queries - Possibly incomplete, could need specific alert retrieval queries
    func getAlerts(completion: @escaping (_ cages: [Alert]?, _ error: Error?) -> Void) {
        guard let url = URL(string: getAlertsURL) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var alerts = [Alert]()
                for item in result {
                    let alert = Alert(alertInfo: item)
                    alerts.append(alert)
                }
                completion(alerts, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
        
    }

    //Settings Query - Should only need this one query unless we add anything specific to the settings table
    func getSettings(completion: @escaping () -> Void) {
        guard let url = URL(string: getSettingsURL) else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let downloadedSettings = response.value as? [String : Any] {
                
                //Mouse information
                if let theBreedingPeriod = downloadedSettings["BreedingPeriod"] {
                    Settings.shared.breedingPeriodNumber = theBreedingPeriod as? Int
                }
                if let theBreedingPeriodUnit = downloadedSettings["BreedingPeriodUnit"] {
                    Settings.shared.breedingPeriodUnit = theBreedingPeriodUnit as? Int
                }
                if let theGestationPeriod = downloadedSettings["GestationPeriod"] {
                    Settings.shared.gestationPeriodNumber = theGestationPeriod as? Int
                }
                if let theGestationPeriodUnit = downloadedSettings["GestationPeriodUnit"] {
                    Settings.shared.gestationPeriodUnit = theGestationPeriodUnit as? Int
                }
                if let theWeaningPeriod = downloadedSettings["WeaningPeriod"] {
                    Settings.shared.weaningPeriodNumber = theWeaningPeriod as? Int
                }
                if let theWeaningPeriodUnit = downloadedSettings["WeaningPeriodUnit"] {
                    Settings.shared.weaningPeriodUnit = theWeaningPeriodUnit as? Int
                }
                if let theMaleLifeSpan = downloadedSettings["MaleLifespan"] {
                    Settings.shared.maleLifeSpanNumber = theMaleLifeSpan as? Int
                }
                if let theMaleLifeSpanUnit = downloadedSettings["MaleLifespanUnit"] {
                    Settings.shared.maleLifeSpanUnit = theMaleLifeSpanUnit as? Int
                }
                if let theFemaleLifeSpan = downloadedSettings["FemaleLifespan"] {
                    Settings.shared.femaleLifeSpanNumber = theFemaleLifeSpan as? Int
                }
                if let theFemaleLifeSpanUnit = downloadedSettings["FemaleLifespanUnit"] {
                    Settings.shared.femaleLifeSpanUnit = theFemaleLifeSpanUnit as? Int
                }
                
                //Alert advance information
                if let theBreedingAlertAdvance = downloadedSettings["BreedingAlertAdvance"], let theBreedingAlertAdvanceUnit = downloadedSettings["BreedingAlertAdvanceUnit"] {
                    Settings.shared.maleInCageAlertAdvanceNumber = theBreedingAlertAdvance as? Int
                    Settings.shared.maleInCageAlertAdvanceUnit = theBreedingAlertAdvanceUnit as? Int
                }
                if let theOldFemaleAlertAdvance = downloadedSettings["OldFemaleAlertAdvance"], let theOldFemaleAlertAdvanceUnit = downloadedSettings["OldFemaleAlertAdvanceUnit"] {
                    Settings.shared.femaleTooOldAlertAdvanceNumber = theOldFemaleAlertAdvance as? Int
                    Settings.shared.femaleTooOldAlertAdvanceUnit = theOldFemaleAlertAdvanceUnit as? Int
                }
                if let theOldMaleAlertAdvance = downloadedSettings["OldMaleAlertAdvance"], let theOldMaleAlertAdvanceUnit = downloadedSettings["OldMaleAlertAdvanceUnit"] {
                    Settings.shared.maleTooOldAlertAdvanceNumber = theOldMaleAlertAdvance as? Int
                    Settings.shared.maleTooOldAlertAdvanceUnit = theOldMaleAlertAdvanceUnit as? Int
                }
                if let thePupsToWeanAlertAdvance = downloadedSettings["WeaningAlertAdvance"], let thePupsToWeanAlertAdvanceUnit = downloadedSettings["WeaningAlertAdvanceUnit"] {
                    Settings.shared.pupsToWeanAlertAdvanceNumber = thePupsToWeanAlertAdvance as? Int
                    Settings.shared.pupsToWeanAlertAdvanceUnit = thePupsToWeanAlertAdvanceUnit as? Int
                }
                
                //Alert colors information
                if let theMaleInCageAlertIconColor = downloadedSettings["MaleInCageColor"] as? Int {
                    Settings.shared.maleInCageAlertIcon = self.textColorToIcon(textColor: String(theMaleInCageAlertIconColor))
                }
                if let thePupsInCageAlertIconColor = downloadedSettings["PupsInCageColor"] as? Int {
                    Settings.shared.pupsInCageAlertIcon = self.textColorToIcon(textColor: String(thePupsInCageAlertIconColor))
                }
                if let thePupsToWeanAlertIconColor = downloadedSettings["PupsToWeanColor"] as? Int {
                    Settings.shared.pupsToWeanAlertIcon = self.textColorToIcon(textColor: String(thePupsToWeanAlertIconColor))
                }
                if let theMaleTooOldAlertIconColor = downloadedSettings["MaleTooOldColor"] as? Int {
                    Settings.shared.maleTooOldAlertIcon = self.textColorToIcon(textColor: String(theMaleTooOldAlertIconColor))
                }
                if let theFemaleTooOldAlertIconColor = downloadedSettings["FemaleTooOldColor"] as? Int {
                    Settings.shared.femaleTooOldAlertIcon = self.textColorToIcon(textColor: String(theFemaleTooOldAlertIconColor))
                }
                if let theCageWithOrderAlertIconColor = downloadedSettings["CageWithOrderColor"] as? Int {
                    Settings.shared.cageWithOrderAlertIcon = self.textColorToIcon(textColor: String(theCageWithOrderAlertIconColor))
                }
                
                //Financial information
                if let theCageCost = downloadedSettings["CageCost"] {
                    Settings.shared.costPerCagePerDay = theCageCost as? Double
                }
                
                if let theFemaleMousePrice = downloadedSettings["FemaleCost"] {
                    Settings.shared.costPerFemaleMouse = theFemaleMousePrice as? Double
                }
                
                if let theMaleMousePrice = downloadedSettings["MaleCost"] {
                    Settings.shared.costPerMaleMouse = theMaleMousePrice as? Double
                }
                
                print("=====Size of Cage Racks Information=====")
                //Mouse storage information
                if let theColumns = downloadedSettings["Columns"] {
                    Settings.shared.numColumns = theColumns as? Int
                    print("  Num Columns: \(Settings.shared.numColumns!)")
                }
                if let theNumRacks = downloadedSettings["Racks"] {
                    Settings.shared.numRacks = theNumRacks as? Int
                    print("  Num Racks: \(Settings.shared.numRacks!)")
                }
                if let theNumRows = downloadedSettings["Rows"] {
                    Settings.shared.numRows = theNumRows as? Int
                    print("  Num Racks: \(Settings.shared.numRows!)")
                }
                print("=========================================")
                completion()
 
            }
            else {
                print("  Error downloading settings in QueryServer.swift")
                completion()
            }
        })
    }
    
    func textColorToIcon(textColor: String) -> UIImage {
        switch textColor {
        case "0":
            return #imageLiteral(resourceName: "RedDot")
        case "1":
            return #imageLiteral(resourceName: "OrangeDot")
        case "2":
            return #imageLiteral(resourceName: "YellowDot")
        case "3":
            return #imageLiteral(resourceName: "GreenDot")
        case "4":
            return #imageLiteral(resourceName: "CyanDot")
        case "5":
            return #imageLiteral(resourceName: "BlueDot")
        case "6":
            return #imageLiteral(resourceName: "PurpleDot")
        case "7":
            return #imageLiteral(resourceName: "PinkDot")
        default:
            print("     textColorToIcon - Default was hit!")
            return #imageLiteral(resourceName: "XIcon")
        }
    }
    
//End GET Queries
    
    
//POST queries
    
    func createNewBreedingCage(id: String?, row: Int?, column: Int?, rack: Int?, isActive: Int?, parentsCagesDOB: [String]?, parentCagesId: [String]?, completion: @escaping (_ error: String?) -> Void) {
        guard let url = URL(string: createNewBreedingCageURL) else {
            completion("Issue with URL in createNewBreedingCage function of QueryServer.swift!")
            return
        }
        
        guard let theId = id else {
            completion("Issue with ID in createNewBreedingCage function of QueryServer.swift!")
            return
        }
        guard let theRow = row else {
            completion("Issue with ROW in createNewBreedingCage function of QueryServer.swift!")
            return
        }
        guard let theColumn = column else {
            completion("Issue with COLUMN in createNewBreedingCage function of QueryServer.swift!")
            return
        }
        guard let theRack = rack else {
            completion("Issue with RACK in createNewBreedingCage function of QueryServer.swift!")
            return
        }
        guard let theIsActive = isActive else {
            completion("Issue with ACTIVE in createNewBreedingCage function of QueryServer.swift!")
            return
        }
        guard let theParentCagesId = parentCagesId, parentCagesId?.count != 0 else {
            completion("Issue with PARENTCAGEID in createNewBreedingCage function of QueryServer.swift!")
            return
        }
        guard let theParentCagesDOB = parentsCagesDOB, parentsCagesDOB?.count != 0 else {
            completion("Issue with PARENTCAGEDOB in createNewBreedingCage function of QueryServer.swift!")
            return
        }
        
        var parents = [[String : String]]()
        
        for i in 0..<theParentCagesId.count {
            for j in 0..<theParentCagesDOB.count {
                if i == j {
                    let parent: [String : String] = ["ParentCageId" : theParentCagesId[i] , "DOB" : theParentCagesDOB[j]]
                    parents.append(parent)
                }
            }
        }
        
        let parameters: Parameters = ["Id" : theId, "Row": theRow, "Column": theColumn, "Rack": theRack, "Active": theIsActive, "ParentCages": parents]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            completion(response.error?.localizedDescription)
        })
    }
    
    func createNewSellingCage(id: String?, row: Int?, column: Int?, rack: Int?, isActive: Int?, parentsCagesDOB: [String]?, parentCagesId: [String]?, gender: Int?, numberOfMice: Int?, completion: @escaping (_ error: String?) -> Void) {
        guard let url = URL(string: createNewSellingCageURL) else {
            completion("Issue with URL in createNewSellingCage function of QueryServer.swift!")
            return
        }
        
        guard let theId = id else {
            completion("Issue with ID in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theRow = row else {
            completion("Issue with ROW in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theColumn = column else {
            completion("Issue with COLUMN in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theRack = rack else {
            completion("Issue with RACK in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theIsActive = isActive else {
            completion("Issue with ACTIVE in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theGender = gender else {
            completion("Issue with GENDER in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theNumberOfMice = numberOfMice else {
            completion("Issue with NUMBEROFMICE in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theParentCagesDOB = parentsCagesDOB, parentsCagesDOB?.count != 0 else {
            completion("Issue with PARENTCAGEDOB in createNewSellingCage function of QueryServer.swift!")
            return
        }
        var theParentCagesId = [String]()
        for date in theParentCagesDOB {
            theParentCagesId.append(theId)
        }
        
        
        var theParents = [[String : String]]()
        
        for i in 0..<theParentCagesId.count {
            for j in 0..<theParentCagesDOB.count {
                if i == j {
                    let parent: [String : String] = ["Id" : theParentCagesId[i] , "DOB" : theParentCagesDOB[j]]
                    theParents.append(parent)
                }
            }
        }
        
        let parameters: Parameters = ["Id" : theId, "Row": theRow, "Column": theColumn, "Rack": theRack, "Active": theIsActive, "ParentCages": theParents, "Gender": theGender, "NumberOfMice": theNumberOfMice]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            completion(response.error?.localizedDescription)
        })
    }
    
    func createNewBreedingMale(id: String?, isActive: Int?, motherCageId: String?, DOB: String?, currentCageId: String?, completion: @escaping (_ error: String?) -> Void) {
        guard let url = URL(string: createNewBreedingMaleURL) else {
            completion("Issue with URL in createNewSellingCage function of QueryServer.swift!")
            return
        }
        
        guard let theId = id else {
            completion("Issue with ID in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theIsActive = isActive else {
            completion("Issue with ACTIVE in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theMotherCageId = motherCageId else {
            completion("Issue with MOTHERCAGEID in createNewBreedingMale function of QueryServer.swift!")
            return
        }
        guard let theCurrentCageId = currentCageId else {
            completion("Issue with CURRENTCAGEID in createNewBreedingMale function of QueryServer.swift!")
            return
        }
        guard let theDOB = DOB else {
            completion("Issue with DOB in createNewBreedingMale function of QueryServer.swift!")
            return
        }
        
        let parameters: Parameters = ["Id" : theId, "Active": theIsActive, "MotherCageId": theMotherCageId, "CurrentCageId": theCurrentCageId, "DOB": theDOB]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            completion(response.error?.localizedDescription)
        })
    }
    
    func createLitterLogEntry(motherCageId: String?, completion: @escaping (_ error: String?) -> Void) {
        guard let url = URL(string: createLitterLogEntryURL) else {
            completion("Issue with URL in createLitterLogEntry function of QueryServer.swift!")
            return
        }
        
        guard let theMotherCageId = motherCageId else {
            completion("Issue with motherCageId in createLitterLogEntry function of QueryServer.swift!")
            return
        }
        
        let parameters: Parameters = ["MotherCageId": theMotherCageId]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            completion(response.error?.localizedDescription)
        })
    }
    
//End POST Queries
   
//Start PATCH Queries
    
    //Update breeding cage
    func updateBreedingCageWith(id: String?, row: String?, column: String?, rack: String?, isActive: String?, weaned: String?, completion: @escaping (_ error: String?) -> Void) {
        guard let theId = id else {
            return
        }
        
        var urlComponents = URLComponents(string: updateBreedingCageWithIDURL+theId)
        var queryItems = [URLQueryItem]()
        
        if let theRow = row {
            queryItems.append(URLQueryItem(name: "row", value: String(theRow)))
        }
        if let theColumn = column {
            queryItems.append(URLQueryItem(name: "column", value: String(theColumn)))
        }
        if let theRack = rack  {
            queryItems.append(URLQueryItem(name: "rack", value: String(theRack)))
        }
        if let theIsActive = isActive {
            queryItems.append(URLQueryItem(name: "active", value: String(theIsActive)))
        }
        if let theWeaned = weaned {
            queryItems.append(URLQueryItem(name: "weaned", value: theWeaned))
        }
        
        urlComponents?.queryItems = queryItems
        
        if let url = urlComponents?.url {
            Alamofire.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                completion(response.error?.localizedDescription)
            })
        }
        
    }
    
    //Update selling cage
    func updateSellingCageWith(id: String?, row: String?, column: String?, rack: String?, isActive: String?, numberOfMice: String?, genderOfMice: String?, cageIdList: [String]?, cageDOBList: [String]?, completion: @escaping (_ error: String?) -> Void) {
        guard let theId = id else {
            return
        }
        
        var urlComponents = URLComponents(string: updateSellingCageWithIDURL+theId)
        var queryItems = [URLQueryItem]()
        
        if let theRow = row {
            queryItems.append(URLQueryItem(name: "row", value: String(theRow)))
        }
        if let theColumn = column {
            queryItems.append(URLQueryItem(name: "column", value: String(theColumn)))
        }
        if let theRack = rack  {
            queryItems.append(URLQueryItem(name: "rack", value: String(theRack)))
        }
        if let theIsActive = isActive {
            queryItems.append(URLQueryItem(name: "active", value: String(theIsActive)))
        }
        if let theNumberOfMice = numberOfMice {
            queryItems.append(URLQueryItem(name: "numberOfMice", value: String(theNumberOfMice)))
        }
        if let theCageGender = genderOfMice {
            queryItems.append(URLQueryItem(name: "gender", value: String(theCageGender)))
        }
        
        urlComponents?.queryItems = queryItems
        
        if let url = urlComponents?.url {
            Alamofire.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                completion(response.error?.localizedDescription)
            })
        }
        
    }
    
    func updateSellingCageDOBsWith(id: String?, dobs: [String]?, completion: @escaping (_ error: String?) -> Void) {
        guard let theId = id else {
            return
        }
        
        guard let theDOBs = dobs, dobs?.count != 0 else {
            completion("Issue with PARENTCAGEDOB in createNewSellingCage function of QueryServer.swift!")
            return
        }
        var theIds = [String]()
        for date in theDOBs {
            theIds.append(theId)
        }
        
        var theParents = [[String : String]]()
        
        for i in 0..<theIds.count {
            for j in 0..<theDOBs.count {
                if i == j {
                    let parent: [String : String] = ["Id" : theIds[i] , "DOB" : theDOBs[j]]
                    theParents.append(parent)
                }
            }
        }

        updateSellingCageDOBsOne(id: theId, parents: theParents) { (error) in
            completion(error)
        }
        
    }
    
    private func updateSellingCageDOBsOne(id: String, parents: [[String : String]],  completion: @escaping (_ error: String?) -> Void) {
        if parents.count <= 0 {
            completion(nil)
        }
        else {
            var theParents = parents
            let parent = theParents.removeFirst()
            updateSellingCageDOBWithTwo(id: id, parent: parent) { (error) in
                self.updateSellingCageDOBsOne(id: id, parents: theParents, completion: completion)
            }
        }
    }
    
    private func updateSellingCageDOBWithTwo(id: String?, parent: [String : String], completion: @escaping (_ error: String?) -> Void) {
        guard let url = URL(string: updateSellingCageDOBWithIDURL) else {
            completion("Error, badly formatted URL!")
            return
        }
        
        guard let theId = id else {
            completion("Error, bad Id!")
            return
        }
        guard let theParentDOB = parent["DOB"] else {
            completion("Error, bad parent DOB!")
            return
        }
        
        let parameters: Parameters = ["ParentCageId" : theId,
                                      "DOB" : theParentDOB,
                                      "CurrentCageId" : theId]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            completion(response.error?.localizedDescription)
        })
        
    }
    
    //Update breeding male
    func updateBreedingMaleWith(id: String?, isActive: String?, currentCageId: String?, dob: String?, completion: @escaping (_ error: String?) -> Void) {
        guard let theId = id else {
            return
        }
        
        var urlComponents = URLComponents(string: updateBreedingMaleWithIDURL+theId)
        var queryItems = [URLQueryItem]()
        
        if let theIsActive = isActive {
            queryItems.append(URLQueryItem(name: "Active", value: String(theIsActive)))
        }
        if let theCurrentCageId = currentCageId {
            queryItems.append(URLQueryItem(name: "CurrentCageId", value: String(theCurrentCageId)))
        }
        if let theDob = dob {
            queryItems.append(URLQueryItem(name: "DOB", value: theDob))
        }
        
        urlComponents?.queryItems = queryItems
        
        if let url = urlComponents?.url {
            Alamofire.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                debugPrint(response)
                if response.response?.statusCode == 200 {
                    completion(nil)
                }
                else {
                    var errorMessage = response.value as? String ?? "There was an unknown error! Please try again."
                    errorMessage = errorMessage.replacingOccurrences(of: "SUCCESS:", with: "")
                    completion(errorMessage)
                }
                
                completion(response.error?.localizedDescription)
            })
        }
        
    }
    
    func updateSettings(parameters: [String : Double], completion: @escaping (_ error: String?) -> Void) {
        if let url = URL(string: updateSettingsURL) {
            let headers: HTTPHeaders = ["Content-Type":"application/json"]
            Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                completion(response.error?.localizedDescription)
            })
        }
    }
    
    
//End PATCH Queries
}

extension Date {
    
    func toString() -> String {
        return self.toString(withFormat: "yyyy-MM-dd HH:mm:ss")
    }
    
    func toString(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let myString = formatter.string(from: self)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = format
        
        return formatter.string(from: yourDate!)
    }
    
}
