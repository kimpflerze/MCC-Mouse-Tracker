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
        
        print("*****I turned off auto-layout UIConstraintBasedLayoutLogUnsatisfiable in the ViewController.swift viewDidLoad function!*****")
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        print("[TO-DO] Complete login process in ViewController.swift")
        print("[TO-DO] Complete query for app settings in ViewController.swift & Settings.swift")
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

