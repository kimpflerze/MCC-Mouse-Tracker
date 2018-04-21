//
//  RackUtility.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 4/21/18.
//  Copyright © 2018 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class RackUtility: NSObject {

    static let shared = RackUtility()
    var breedingCages = [Cage]()
    var sellingCages = [Cage]()
    var breedingMales = [BreedingMale]()
    
    var firstDownloadComplete = false
    
    func downloadMouseInformation(completion: @escaping (_ success: Bool, _ error: String?) -> Void){
        QueryServer.shared.getAllActiveBreedingCages { (downloadedCages, error) in
            if let theCages = downloadedCages {
                self.breedingCages = theCages
                DispatchQueue.main.async {
                    
                    QueryServer.shared.getAllActiveSellingCages { (downloadedCages, error) in
                        if let theCages = downloadedCages {
                            self.sellingCages = theCages
                            DispatchQueue.main.async {
                                
                                QueryServer.shared.getAllActiveBreedingMales { (downloadedMales, error) in
                                    if let theMales = downloadedMales {
                                        self.breedingMales = theMales
                                        self.breedingCages = self.breedingCages.map({ (cage) -> Cage in
                                            let newCage = cage
                                            newCage.maleInCage = theMales.contains(where: { (male) -> Bool in
                                                cage.maleInCage = true
                                                return male.currentCageId == cage.id
                                            })
                                            return newCage
                                        })
                                        DispatchQueue.main.async {
                                            self.firstDownloadComplete = true
                                            completion(true, nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
