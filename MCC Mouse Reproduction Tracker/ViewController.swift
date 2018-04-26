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
        
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let inputUserName = usernameTextField.text else {
            return
        }
        guard let inputPassword = passwordTextField.text else {
            return
        }
        
        //Query the server here to confirm login credentials - Login not implemented!
        
        Settings.shared.userName = inputUserName
        
        //Download settings from database
        let downloadSettingsHUD = MBProgressHUD.showAdded(to: view, animated: true)
        downloadSettingsHUD.detailsLabel.text = "Downloading settings..."
        QueryServer.shared.getSettings {
            DispatchQueue.main.async {
                downloadSettingsHUD.hide(animated: true)
                self.performSegue(withIdentifier: "loginToPageView", sender: sender)
            }
        }
    }
    
    //Function to check for blank username/password textfields - Login not implemented!
    func blankTextField(input: String) -> Bool {
        return true
    }

}

