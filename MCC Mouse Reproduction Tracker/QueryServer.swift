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
    
    //Timestamp referenced to determine if the current user should be timed out
    var lastActivityTimeStamp: Date?
    
//GET Queries
    //Breeding cages queries
    func getAllBreedingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingcage") else {
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
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingcage?active=1") else {
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
    
    func getBreedingCageBy(id: String, completion: @escaping (_ cage: Cage?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingcage?\(id)") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            debugPrint(response)
            if let result = response.value as? [[String : Any]] {
                var cage: Cage?
                for item in result {
                    cage = Cage(rackInfo: item)
                    cage?.isBreeding = true
                }
                completion(cage, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
    }
    
    
    //Selling cage queries
    func getAllSellingCages(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/sellingcage") else {
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
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/sellingcage?active=1") else {
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
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/sellingcage?\(id)") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var cage: Cage?
                for item in result {
                    cage = Cage(rackInfo: item)
                    cage?.isBreeding = false
                }
                completion(cage, nil)
            }
            else {
                completion(nil, response.error)
            }
        })
    }
    
    
    //Breeding male queries
    func getAllBreedingMales(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingmale") else {
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
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingmale?active=1") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let result = response.value as? [[String : Any]] {
                var males = [BreedingMale]()
                for item in result {
                    let male = BreedingMale(maleInfo: item)
                    print("BreedingMale CurrentCageId: \(male.currentCageId)")
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
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/sellingcage?\(id)") else {
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
    
    func getBreedingMaleBy(cageId: String, completion: @escaping (_ cage: BreedingMale?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingmale?currentCageId=\(cageId)") else {
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
    
    
    //Litter log queries - Incomplete, need individual log retrieval queries
    func getAllLitterLogs(completion: @escaping (_ cages: [Cage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/litterlog") else {
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
    
    //Alerts queries - Possibly incomplete, could need specific alert retrieval queries
    func getAlerts(completion: @escaping (_ cages: [Alert]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/alert") else {
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
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/settings/1") else {
            return
        }
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if let downloadedSettings = response.value as? [String : Any] {
                print("[TO-DO] Complete getSettings query in QueryServer.swift!")
                
                print("==Downloaded Settings==")
                
                //Might have to implement this later on, all "Periods" should be dates though, not Ints
                /*
                 
                if let theBreedingPeriod = downloadedSettings["BreedingPeriod"] {
                    Settings.shared.breedingPeriod = theBreedingPeriod as? Date
                    debugPrint(theBreedingPeriod)
                }
                 
                 if let theFemaleMouseLifespan = downloadedSettings["FemaleLifespan"] {
                    Settings.shared.femaleLifeSpan = theFemaleMouseLifespan as? Int
                 }
                 
                 if let theMaleMouseLifespan = downloadedSettings["MaleLifespan"] {
                    Settings.shared.maleLifeSpan = theMaleMouseLifespan as? Int
                 }
                 
                 if let theGestationPeriod = downloadedSettings["GestationPeriod"] {
                    Settings.shared.gestationPeriod = theGestationPeriod as? Int
                 }
                 
                 if let theWeaningPeriod = downloadedSettings["WeaningPeriod"] {
                    Settings.shared.weaningPeriod = theWeaningPeriod as? Int
                 }
                 
                */
                
                if let theCageCost = downloadedSettings["CageCost"] {
                    Settings.shared.costPerCagePerDay = theCageCost as? Double
                    print(" Cost of Cage per Day: \(Settings.shared.costPerCagePerDay!)")
                }
                
                if let theColumns = downloadedSettings["Columns"] {
                    Settings.shared.numColumns = theColumns as? Int
                    print(" Num Columns: \(Settings.shared.numColumns!)")
                }
                
                if let theFemaleMousePrice = downloadedSettings["FemaleCost"] {
                    Settings.shared.costPerFemaleMouse = theFemaleMousePrice as? Double
                    print(" Cost per Female: \(Settings.shared.costPerFemaleMouse!)")
                }
                
                if let theMaleMousePrice = downloadedSettings["MaleCost"] {
                    Settings.shared.costPerMaleMouse = theMaleMousePrice as? Double
                    print(" Cost per Male: \(Settings.shared.costPerMaleMouse!)")
                }
                
                if let theNumRacks = downloadedSettings["Racks"] {
                    Settings.shared.numRacks = theNumRacks as? Int
                    print(" Num Racks: \(Settings.shared.numRacks!)")
                }
                if let theNumRows = downloadedSettings["Rows"] {
                    Settings.shared.numRows = theNumRows as? Int
                    print(" Num Racks: \(Settings.shared.numRows!)")
                }
                
                print("==End Settings==")
                
                completion()
 
            }
            else {
                print("Error downloading settings in QueryServer.swift")
                completion()
            }
        })
    }
    
//End GET Queries
    
    
//POST queries
    
    func createNewBreedingCage(id: String?, row: Int?, column: Int?, rack: Int?, isActive: Int?, parentsCagesDOB: [String]?, parentCagesId: [String]?, completion: @escaping (_ error: String?) -> Void) {
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingcage") else {
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
                if j == j {
                    let parent: [String : String] = ["Id" : theParentCagesId[i] , "DOB" : theParentCagesDOB[j]]
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
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/sellingcage") else {
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
        guard let theParentCagesId = parentCagesId, parentCagesId?.count != 0 else {
            completion("Issue with PARENTCAGEID in createNewSellingCage function of QueryServer.swift!")
            return
        }
        guard let theParentCagesDOB = parentsCagesDOB, parentsCagesDOB?.count != 0 else {
            completion("Issue with PARENTCAGEDOB in createNewSellingCage function of QueryServer.swift!")
            return
        }
        
        var theParents = [[String : String]]()
        
        for i in 0..<theParentCagesId.count {
            for j in 0..<theParentCagesDOB.count {
                if j == j {
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
        guard let url = URL(string: "https://mouseapi.azurewebsites.net/api/breedingmale") else {
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
    
//End POST Queries
   
//Start PATCH Queries
    
    //Update breeding cage
    func updateBreedingCageWith(id: String?, row: String?, column: String?, rack: String?, isActive: String?, completion: @escaping (_ error: String?) -> Void) {
        let templateURL = "https://mouseapi.azurewebsites.net/api/breedingcage/"
        guard let theId = id else {
            return
        }
        
        var urlComponents = URLComponents(string: templateURL+theId)
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
        
        urlComponents?.queryItems = queryItems
        
        if let url = urlComponents?.url {
            Alamofire.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                debugPrint(response)
                completion(response.error?.localizedDescription)
            })
        }
        
    }
    
    //Update selling cage
    func updateSellingCageWith(id: String?, row: String?, column: String?, rack: String?, isActive: String?, numberOfMice: String?, completion: @escaping (_ error: String?) -> Void) {
        let templateURL = "https://mouseapi.azurewebsites.net/api/sellingcage/"
        guard let theId = id else {
            return
        }
        
        var urlComponents = URLComponents(string: templateURL+theId)
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
        
        urlComponents?.queryItems = queryItems
        
        if let url = urlComponents?.url {
            Alamofire.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                debugPrint(response)
                completion(response.error?.localizedDescription)
            })
        }
        
    }
    
    //Update breeding male
    func updateBreedingMaleWith(id: String?, isActive: String?, currentCageId: String?, completion: @escaping (_ error: String?) -> Void) {
        let templateURL = "https://mouseapi.azurewebsites.net/api/breedingmale/"
        guard let theId = id else {
            return
        }
        
        var urlComponents = URLComponents(string: templateURL+theId)
        var queryItems = [URLQueryItem]()
        
        if let theIsActive = isActive {
            queryItems.append(URLQueryItem(name: "active", value: String(theIsActive)))
        }
        if let theCurrentCageId = currentCageId {
            queryItems.append(URLQueryItem(name: "currentCageId", value: String(theCurrentCageId)))
        }
        
        urlComponents?.queryItems = queryItems
        
        if let url = urlComponents?.url {
            Alamofire.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                debugPrint(response)
                completion(response.error?.localizedDescription)
            })
        }
        
    }
    
    func updateSettings(parameters: [String : String], completion: @escaping (_ error: String?) -> Void) {
        let templateURL = "https://mouseapi.azurewebsites.net/api/settings"
        var urlComponents = URLComponents(string: templateURL)
        var queryItems = [URLQueryItem]()
        
        let keys = parameters.keys
        for key in keys {
            queryItems.append(URLQueryItem(name: key, value: parameters[key]!))
        }
        
        urlComponents?.queryItems = queryItems
        if let url = urlComponents?.url {
            Alamofire.request(url, method: .put, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                debugPrint(response)
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
