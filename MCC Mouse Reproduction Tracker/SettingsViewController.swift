//
//  SettingsViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/20/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import SwiftValidator
import MBProgressHUD

class SettingsViewController: UIViewController, UITextFieldDelegate, ValidationDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var pickOption = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                     "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                     "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"], ["day(s)", "week(s)", "month(s)"]]
    
    // Validator Variable
    let validator = Validator()
    // Textfields
    @IBOutlet weak var numRacksTextField: UITextField!
    @IBOutlet weak var numRowsTextField: UITextField!
    @IBOutlet weak var numColumnsTextField: UITextField!
    
    @IBOutlet weak var weaningPeriodTextField: UITextField!
    @IBOutlet weak var breedingPeriodTextField: UITextField!
    @IBOutlet weak var gestationPeriodTextField: UITextField!
    
    
    @IBOutlet weak var maleLifeSpanTextField: UITextField!
    @IBOutlet weak var femaleLifeSpanTextField: UITextField!
    @IBOutlet weak var maleCostTextField: UITextField!
    @IBOutlet weak var femaleCostTextField: UITextField!
    @IBOutlet weak var cageCostTextField: UITextField!
    
    //Buttons
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numRacksTextField.delegate = self
        numRowsTextField.delegate = self
        numColumnsTextField.delegate = self
        
        maleLifeSpanTextField.delegate = self
        femaleLifeSpanTextField.delegate = self
        maleCostTextField.delegate = self
        femaleCostTextField.delegate = self
        cageCostTextField.delegate = self
        
        //Filling the text fields with downloaded information - Complete the rest of these!
        if let theNumRacks = Settings.shared.numRacks {
            numRacksTextField.text = String(theNumRacks)
        }
        if let theNumRows = Settings.shared.numRows {
            numRowsTextField.text = String(theNumRows)
        }
        if let theNumColumns = Settings.shared.numColumns {
            numColumnsTextField.text = String(theNumColumns)
        }
        
        
        validator.registerField(numRacksTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(numRowsTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(numColumnsTextField, rules: [RequiredRule(), NumericRule()])
        
        validator.registerField(maleCostTextField, rules: [RequiredRule(), CurrencyRule()])
        validator.registerField(femaleCostTextField, rules: [RequiredRule(), CurrencyRule()])
        validator.registerField(maleCostTextField, rules: [RequiredRule(), CurrencyRule()])
        validator.registerField(cageCostTextField, rules: [RequiredRule(), CurrencyRule()])
        
        
        let weaningPickerView = UIPickerView()
        let breedingPickerView = UIPickerView()
        let gestationPickerView = UIPickerView()
        let maleLifeSpanPickerView = UIPickerView()
        let femaleLifeSpanPickerView = UIPickerView()
        
        
        weaningPickerView.delegate = self
            weaningPickerView.tag = 0
        breedingPickerView.delegate = self
            breedingPickerView.tag = 1
        gestationPickerView.delegate = self
            gestationPickerView.tag = 2
        maleLifeSpanPickerView.delegate = self
            maleLifeSpanPickerView.tag = 3
        femaleLifeSpanPickerView.delegate = self
            femaleLifeSpanPickerView.tag = 4
        
        weaningPeriodTextField.inputView = weaningPickerView
        breedingPeriodTextField.inputView = breedingPickerView
        gestationPeriodTextField.inputView = gestationPickerView
        maleLifeSpanTextField.inputView = maleLifeSpanPickerView
        femaleLifeSpanTextField.inputView = femaleLifeSpanPickerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Function is called if all registered fields are validated sucessfully
     */
    func validationSuccessful(){
        print("textField validation successful!!")
        numRacksTextField.layer.borderColor = UIColor.green.cgColor
        numRacksTextField.layer.borderWidth = 1.0
        
        numRowsTextField.layer.borderColor = UIColor.green.cgColor
        numRowsTextField.layer.borderWidth = 1.0
        
        numColumnsTextField.layer.borderColor = UIColor.green.cgColor
        numColumnsTextField.layer.borderWidth = 1.0
        
        maleCostTextField.layer.borderColor = UIColor.green.cgColor
        maleCostTextField.layer.borderWidth = 1.0
        
        femaleCostTextField.layer.borderColor = UIColor.green.cgColor
        femaleCostTextField.layer.borderWidth = 1.0
        
        cageCostTextField.layer.borderColor = UIColor.green.cgColor
        cageCostTextField.layer.borderWidth = 1.0
        
        /* SAVE DATA TO DATABASE */
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
    
    
    
     /************************** BUTTON FUNCTIONS **************************/
    
    @IBAction func pressedSaveButton(_ sender: UIButton) {
        //validate fields
        validator.validate(self)
        
    }
    
    @IBAction func pressedDoneButton(_ sender: UIButton) {
        print("[TO-DO] Tell George to make the settings table support PATCH statements, not just PUT!")
        var parameters = [String : String]()
        if(numRacksTextField.text != nil && numRacksTextField.text != "") {
            if let racksNumber = Int(numRacksTextField.text!) {
                parameters["Racks"] = String(racksNumber)
            }
        }
        if(numRowsTextField.text != nil && numRowsTextField.text != "") {
            if let rowsNumber = Int(numRowsTextField.text!) {
                parameters["Rows"] = String(rowsNumber)
            }
        }
        if(numColumnsTextField.text != nil && numColumnsTextField.text != "") {
            if let columnsNumber = Int(numColumnsTextField.text!) {
                parameters["Columns"] = String(columnsNumber)
            }
        }
        if(maleCostTextField.text != nil && maleCostTextField.text != "") {
            if let maleCost = Int(maleCostTextField.text!) {
                parameters["MaleCost"] = String(maleCost)
            }
        }
        if(femaleCostTextField.text != nil && femaleCostTextField.text != "") {
            if let femaleCost = Int(femaleCostTextField.text!) {
                parameters["FemaleCost"] = String(femaleCost)
            }
        }
        if(cageCostTextField.text != nil && cageCostTextField.text != "") {
            if let cageCost = Int(cageCostTextField.text!) {
                parameters["CageCost"] = String(cageCost)
            }
        }
        //Any "Period" will most likely have to be udpated later!
        print("[TO-DO] Update period information in the SettingsViewController doneButtonPressed Method!")
        if(weaningPeriodTextField.text != nil && weaningPeriodTextField.text != "") {
            if let weaningPeriod = Int(weaningPeriodTextField.text!) {
                parameters["WeaningPeriod"] = String(weaningPeriod)
            }
        }
        if(breedingPeriodTextField.text != nil && breedingPeriodTextField.text != "") {
            if let breedingPeriod = Int(breedingPeriodTextField.text!) {
                parameters["BreedingPeriod"] = String(breedingPeriod)
            }
        }
        if(gestationPeriodTextField.text != nil && gestationPeriodTextField.text != "") {
            if let gestationPeriod = Int(gestationPeriodTextField.text!) {
                parameters["GestationPeriod"] = String(gestationPeriod)
            }
        }
        if(maleLifeSpanTextField.text != nil && maleLifeSpanTextField.text != "") {
            if let maleLifespan = Int(maleLifeSpanTextField.text!) {
                parameters["MaleLifespan"] = String(maleLifespan)
            }
        }
        if(femaleLifeSpanTextField.text != nil && femaleLifeSpanTextField.text != "") {
            if let femaleLifespan = Int(femaleLifeSpanTextField.text!) {
                parameters["FemaleLifespan"] = String(femaleLifespan)
            }
        }
        
        let updatingSettingsHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        updatingSettingsHUD.detailsLabel.text = "Updating settings..."
        QueryServer.shared.updateSettings(parameters: parameters) { (error) in
            
            updatingSettingsHUD.detailsLabel.text = "Downloading settings..."
            QueryServer.shared.getSettings { 
                DispatchQueue.main.async {
                    updatingSettingsHUD.hide(animated: true)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updatedSettings"), object: nil)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    /**********************************************************************/
    
    
    
    
    /************************* PICKERVIEW FUNCTIONS *************************/
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return pickOption[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let count = pickOption[0][pickerView.selectedRow(inComponent: 0)]
        let option = pickOption[1][pickerView.selectedRow(inComponent: 1)]
        
        if pickerView.tag == 0{
            weaningPeriodTextField.text = count + " " + option
        }else if pickerView.tag == 1{
            breedingPeriodTextField.text = count + " " + option
        }else if pickerView.tag == 2 {
            gestationPeriodTextField.text = count + " " + option
        }else if pickerView.tag == 3 {
            maleLifeSpanTextField.text = count + " " + option
        }else {
            femaleLifeSpanTextField.text = count + " " + option
        }
    }
    /***********************************************************************/
    
    
    
    /************************ TEXTFIELD FUNCTIONS *************************/
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == weaningPeriodTextField {
            return false; //do not show keyboard nor cursor
        }
        return true
    }
    /***********************************************************************/
    
    
    
    
    
    /************************** VALIDATION RULES **************************/
    
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
    
    
    /**
     * Matches any number of length 1 or greater that does
     * not have a leading zero.
     */
    class CurrencyRule: RegexRule {
        
        static let regex = "^([1-9][0-9]| 0)*[\\.]\\d\\d"
        
        convenience init(message : String = "Not valid currency format"){
            self.init(regex: CurrencyRule.regex, message : message)
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
