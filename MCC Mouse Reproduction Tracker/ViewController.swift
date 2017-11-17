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
        loginButton.backgroundColor = Settings.shared.masseyCancerCenterYellow
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        print("Now viewing: Login Screen (ViewController)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
<<<<<<< HEAD
=======
    
    @IBAction func breedingCageButtonPressed(_ sender: UIButton) {
        print("breeding Cage button Pressed")
        let storyboard = UIStoryboard(name: "breedingCage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InitialController") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func stockCageButtonPressed(_ sender: UIButton) {
        print("stock Cage button Pressed")
        let storyboard = UIStoryboard(name: "stockCage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InitialController") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
    }
>>>>>>> feature/cageViews

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        print("Login Button Pressed!")
        
        guard let inputUserName = usernameTextField.text else {
            blankTextField()
            return
        }
        guard let inputPassword = passwordTextField.text else {
            blankTextField()
            return
        }
        
        //Query the server here to confirm login credentials, 
        
        
        //Temporary segue just for testing purposes, should be a check for the login information here!
        performSegue(withIdentifier: "loginToPageView", sender: sender)
        
        /*
        let loginErrorAlert = UIAlertController(title: "Login Error!", message: "Username/Password incorrect!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        loginErrorAlert.addAction(cancelAction)
        self.present(loginErrorAlert, animated: true, completion: nil)
        */
 
    }
    
    func blankTextField() {
        
    }

}

