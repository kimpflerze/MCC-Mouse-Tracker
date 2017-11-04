//
//  ViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 10/29/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    //This is the login screens ViewController!

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Now viewing: Login Screen (ViewController)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        print("Login Button Pressed!")
        
        //Temporary segue just for testing purposes, should be a check for the login information here!
        performSegue(withIdentifier: "loginToPageView", sender: sender)
        
        /*
        if let url = URL(string: "http://jasmine.cs.vcu.edu:20038/~kimpflerze/login.php"), let email = usernameTextField.text, let password = passwordTextField.text {
            let parameters: Parameters = ["email" : email, "password" : password]
            Alamofire.request(url, parameters: parameters).responseJSON(completionHandler: { (response) in
                if let result = response.value as? [String : String] {
                    if let error = result["error"] {
                        let alert = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
//                        User.shared.username = result["USERNAME"]
//                        User.shared.email = result["EMAIL"]
                        if let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "Home") as? ViewController {
                            self.navigationController?.pushViewController(homeVC, animated: true)
                        }
                    }
                }
            })
        }
        */
        
        
        
        /*
        let loginErrorAlert = UIAlertController(title: "Login Error!", message: "Username/Password incorrect!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        loginErrorAlert.addAction(cancelAction)
        self.present(loginErrorAlert, animated: true, completion: nil)
         */
    }

}

