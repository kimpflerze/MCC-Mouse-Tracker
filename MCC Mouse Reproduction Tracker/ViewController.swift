//
//  ViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 10/29/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

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
//        performSegue(withIdentifier: "loginToRackView", sender: sender)
        
        
        
        /*
        let loginErrorAlert = UIAlertController(title: "Login Error!", message: "Username/Password incorrect!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        loginErrorAlert.addAction(cancelAction)
        self.present(loginErrorAlert, animated: true, completion: nil)
         */
    }

}

