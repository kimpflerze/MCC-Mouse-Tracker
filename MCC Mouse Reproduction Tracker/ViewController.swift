//
//  ViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 10/29/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ViewController: UIViewController {
    
    //This is the login screens ViewController!

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginButton.backgroundColor = Settings.shared.masseyCancerCenterYellow
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        
        printToDoLog()
        
//        print("*****I turned off auto-layout UIConstraintBasedLayoutLogUnsatisfiable in the ViewController.swift viewDidLoad function!*****")
//        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    
    func printToDoLog() {
        print("[TO-DO] Fix male in cage icon moving around after refreshing view")
        print("[TO-DO] Complete settings button in RackViewController.swift!")
        print("[TO-DO] Make orders object and query to retrieve the information! Get george to make this endpoint!")
        print("[TO-DO] Tell George to make the settings table support PATCH statements, not just PUT!")
        print("[TO-DO] Update period information in the SettingsViewController doneButtonPressed Method!")
        print("[TO-DO] Complete getSettings query in QueryServer.swift!")
        print("[TO-DO] Come back and fix this date information in Alert.swift")
        print("[TO-DO] Complete login process in ViewController.swift")
        print("[TO-DO] Complete query for app settings in ViewController.swift & Settings.swift")
        print("[TO-DO] Complete inserting information for existing breeding males in addMaleViewController.swift")
        print("[TO-DO] Complete pushing new information to database in addMaleViewController.swift")
        print("[TO-DO] Prevent pushing new breeding male if information is missing!")
        print("[TO-DO] Add functionality for ScanParentInfo button!")
        print("[TO-DO] Add functionality for the AddLitter button!")
        print("[TO-DO] Correct XIcon not showing in breedingCageViewController.swift")
        print("[TO-DO] Complete pushing new information to database in breedingCageViewController.swift")
        print("[TO_DO] Complete idiot proofing for done button in breedingCageViewController.swift")
        print("[TO-DO] Fix this validator POD in all classes where its used! Its funky.")
        print("[TO-DO] Complete add parent info scanning in BreedingCageViewController.swift")
        print("[TO-DO] Add/fix button to allow setting DOB of mice int he cage!")
        print("[TO-DO] Complete pushing new information to database in stockCageViewController.swift")
        print("[TO_DO] Complete idiot proofing for done button in stockCageViewController.swift")
        print("[TO_DO] LitterDOB in Cage.swift still needs to be completed!")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let inputUserName = usernameTextField.text else {
//            blankTextField()
            return
        }
        guard let inputPassword = passwordTextField.text else {
//            blankTextField()
            return
        }
        
        //Query the server here to confirm login credentials, 
        
        
        //Temporary segue just for testing purposes, should be a check for the login information here!
        let downloadSettingsHUD = MBProgressHUD.showAdded(to: view, animated: true)
        downloadSettingsHUD.detailsLabel.text = "Downloading settings..."
        QueryServer.shared.getSettings {
            DispatchQueue.main.async {
                downloadSettingsHUD.hide(animated: true)
                self.performSegue(withIdentifier: "loginToPageView", sender: sender)
            }
        }
        
//        QueryServer.shared.getSettings { (error) in
//            downloadSettingsHUD.hide(animated: true)
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "loginToPageView", sender: sender)
//            }
//        }
    }
    
    //Function to check for blank username/password textfields
    func blankTextField(input: String) -> Bool {
        return true
    }

}

