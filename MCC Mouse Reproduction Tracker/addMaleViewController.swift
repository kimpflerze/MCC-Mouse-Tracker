//
//  addMaleViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import SwiftValidator

class addMaleViewController: UIViewController, UITableViewDelegate,
UITableViewDataSource, UITextFieldDelegate, ValidationDelegate{
    
    // Validator Variable
    let validator = Validator()
    
    // Data Variables
    var parentCageIDList = [String]()
    
    //TextFields
    @IBOutlet weak var rackNoTextField: UITextField!
    @IBOutlet weak var columnNoTextField: UITextField!
    @IBOutlet weak var rowNoTextField: UITextField!
    @IBOutlet weak var maleDOBTextField: UITextField!
    
    @IBOutlet weak var parentCageIDTextField: UITextField!

    //Buttons
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addParentCageIDButton: UIButton!
    @IBOutlet weak var QRCodeButton: UIButton!
    
    //TableViews
    @IBOutlet weak var parentCageIDTableView: UITableView!
    
    
    
    /************************* VIEW CONTROLLER FUNCTIONS *************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        parentCageIDTableView.dataSource = self
        parentCageIDTableView.delegate = self
        
        //Register textfields for validation
        validator.registerField(parentCageIDTextField, rules: [RequiredRule(),NumericRule()])
        validator.registerField(maleDOBTextField, rules: [RequiredRule(),ValidDateRule()])
        validator.registerField(rackNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rowNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(columnNoTextField, rules: [RequiredRule(), NumericRule()])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        parentCageIDTableView.reloadData()
    }
    /**
     * Function is called if all registered fields are validated sucessfully
     */
    func validationSuccessful(){
        /* save textfield information database */
        maleDOBTextField.layer.borderColor = UIColor.green.cgColor
        maleDOBTextField.layer.borderWidth = 1.0
        
        parentCageIDTextField.layer.borderColor = UIColor.green.cgColor
        parentCageIDTextField.layer.borderWidth = 1.0
        
        rackNoTextField.layer.borderColor = UIColor.green.cgColor
        rackNoTextField.layer.borderWidth = 1.0
        
        rowNoTextField.layer.borderColor = UIColor.green.cgColor
        rowNoTextField.layer.borderWidth = 1.0
        
        columnNoTextField.layer.borderColor = UIColor.green.cgColor
        columnNoTextField.layer.borderWidth = 1.0
        
        print("textField validation successful!!")
        
        
        /* SAVE DATA TO DATABASE AND DIRECT USER TO PROPER VIEW HERE */
    }
    
    /**
     * Function is called if any registered field validation fails.
     */
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
        }
    }
    //***********************************************************************/
    
    
    
    /************************* BUTTON FUNCTIONS *************************/
    /**
     * Directs user to the QRScannerView when QR_Code button is pressed.
     */
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        print("pressed QR Code button")
    }
    
    /**
     * Directs user to previous view (BreedingCageViewController) when information
     * is correctly put in
     */
    @IBAction func pressed_done_btn(_ sender: UIButton) {
        print("pressed done button")
        /* validate fields */
        validator.validate(self)
    }
    
    @IBAction func pressed_addParentCageIDButton(_ sender: UIButton) {
        if textFieldShouldReturn(parentCageIDTextField) == true {
            print("pressed add parent cage ID button")
            
            if(parentCageIDTextField.text != "")
            {
                parentCageIDList.append(parentCageIDTextField.text!)
                print("     We added a parent cage ID!")
                parentCageIDTableView.reloadData()
            }
        }else {
            print(parentCageIDTextField.text! + " is an invalid entry")
        }
    }
    /***********************************************************************/
    
    
    
    
    
    /************************* TEXTFIELD FUNCTIONS *************************/
    
    /**
     *
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var result = true
        validator.validateField(textField){ error in
            if error == nil {
                // Field validation was successful
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
                print("textField validation successful!!")
                result = true
            } else {
                // Validation error occurred
                print(error?.errorMessage ?? textField.text! + "is an invalid entry")
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
                result = false
            }
        }
        return result
    }
    
    /**
     * Displays a Date picker when the stockCageDOBTextField starts to be edited.
     */
    @IBAction func maleDOBEditing(_ sender: UITextField) {
        
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(breedingCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    /**
     * Formats the date from the datepicker into the form dd/MM/YY.
     */
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        maleDOBTextField.text = dateFormatter.string(from: sender.date)
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
    }
     /***********************************************************************/
    
    
    
    
    
    
    
     /************************* TABLEVIEW FUNCTIONS *************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentCageIDList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell")
        cell.textLabel?.text = parentCageIDList[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            parentCageIDList.remove(at: indexPath.row)
            parentCageIDTableView.reloadData()}
    }
     /***********************************************************************/
    
  
    
    
    
    
    /*************************** VALIDATION RULES **************************/
    
    /**
     * Matches dates with either format M/dd/yy or MM/dd/yy i.e) 7/10/17 or 07/10/17
     */
    class ValidDateRule: RegexRule {
        
        static let regex = "^([1-9]|0[1-9]|1[012])[/](0[1-9]|[12][0-9]|3[01])[/]\\d\\d$"
        
        convenience init(message : String = "Not a valid date (format: MM/dd/yy or M/dd/yy)"){
            self.init(regex: ValidDateRule.regex, message : message)
        }
    }
    
    /**
     * Matches any number of length 1 or greater that does not have a leading zero
     */
    class NumericRule: RegexRule {
        
        static let regex = "^[1-9][0-9]*"
        
        convenience init(message : String = "Not a valid number"){
            self.init(regex: NumericRule.regex, message : message)
        }
    }
    /***********************************************************************/

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
