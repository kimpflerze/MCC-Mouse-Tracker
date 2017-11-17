//
//  breedingCageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import SwiftValidator

class breedingCageViewController: UIViewController, UITableViewDelegate,
UITableViewDataSource, UITextFieldDelegate, ValidationDelegate {
    
    // Validator Variable
    let validator = Validator()
    
    // Data Variables
    var parentDOBList = [String]()
    var parentCageList = [String]()
    
    // Buttons
    @IBOutlet weak var add_litter_btn: UIButton!
    
    @IBOutlet weak var QR_code_btn: UIButton!
    
    @IBOutlet weak var add_male_btn: UIButton!

    @IBOutlet weak var done_btn: UIButton!
    
    @IBOutlet weak var addParentDOBButton: UIButton!
    
    @IBOutlet weak var addParentCageButton: UIButton!
    
    
    // TextFields
    @IBOutlet weak var rackNoTextField: UITextField!
    
    @IBOutlet weak var rowNoTextField: UITextField!
    
    @IBOutlet weak var columnNoTextField: UITextField!
    
    @IBOutlet weak var parentDOBTextField: UITextField!
    
    @IBOutlet weak var parentCageTextField: UITextField!
    
    
    //TableViews
    @IBOutlet weak var parentDOBTableView: UITableView!
    
    @IBOutlet weak var parentCageTableView: UITableView!
    
    
    /************************* VIEW CONTROLLER FUNCTIONS *************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        parentDOBTableView.dataSource = self
        parentDOBTableView.delegate = self
        
        parentCageTableView.dataSource = self
        parentCageTableView.delegate = self
        
        parentDOBTextField.delegate = self
        parentCageTextField.delegate = self
        
        rackNoTextField.delegate = self
        rowNoTextField.delegate = self
        columnNoTextField.delegate = self
        
        
        
        //Register textfields for validation
    validator.registerField(parentDOBTextField, rules: [RequiredRule(),ValidDateRule()])
        validator.registerField(parentCageTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rackNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rowNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(columnNoTextField, rules: [RequiredRule(), NumericRule()])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Function is called if all registered fields are validated sucessfully
     */
    func validationSuccessful(){
        /* save textfield information database */
        parentCageTextField.layer.borderColor = UIColor.green.cgColor
        parentCageTextField.layer.borderWidth = 1.0
        
        parentDOBTextField.layer.borderColor = UIColor.green.cgColor
        parentDOBTextField.layer.borderWidth = 1.0
        
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
    
    /**
     * Reloads the data of the tableViews upon appearing.
     */
    override func viewDidAppear(_ animated: Bool) {
        parentDOBTableView.reloadData()
        parentCageTableView.reloadData()
    }
    /*****************************************************************************/
    
    
    
    
    
    
    
    
   /****************************** BUTTON FUNCTIONS *****************************/
    
    /**
     * Directs user to the QRScannerView when QR_Code button is pressed.
     */
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        print("pressed QR Code button")
    }
    
    /**
     * Displays an addLitterView when add_litter_btn is pressed.
     */
    @IBAction func pressed_add_litter_btn(_ sender: UIButton) {
        print("pressed Add litter button")
    }
    
    /**
     * Directs user to addMaleView when add_male_btn is pressed
     */
    @IBAction func pressed_add_male_btn(_ sender: UIButton) {
        print("pressed Add Male button")
        
        let storyboard = UIStoryboard(name: "addBreedingMale", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InitialController") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
    }
    
    /**
     * Directs user to previous view (RackViewController) when information
     * is correctly put in
     */
    @IBAction func pressed_done_btn(_ sender: UIButton) {
        print("pressed done button")
        /* validate fields */
            validator.validate(self)
    }
   
    /**
     * Asserts that the text in the parentDOBTextField is in the proper date format.
     * If so, the text is added to parentDOBList and the corresponding TableView is
     * reloaded to show the new data. If not the user is presented an alert asking
     * them to fix their input.
     */
    @IBAction func pressed_addParentDOBButton(_ sender: UIButton) {
        if textFieldShouldReturn(parentDOBTextField) == true {
            print("pressed add parent DOB button")
            
            if(parentDOBTextField.text != "")
            {
                parentDOBList.append(parentDOBTextField.text!)
                print("     We added a parent DOB")
                parentDOBTableView.reloadData()
            }
        }else {
            print(parentDOBTextField.text! + " is an invalid entry")
        }
    }
    
    /**
     * Asserts that the text in the parentCageTextField consists of only numerical 
     * values. If so, the text is added to parentDOBList and the corresponding 
     * TableView is reloaded to show the new data. If not the user is presented an
     * alert asking them to fix their input.
     */
    @IBAction func pressed_addParentCageButton(_ sender: UIButton) {
        if textFieldShouldReturn(parentCageTextField) == true {
            
            print("pressed add parent cage button")
            
            if(parentCageTextField.text != "")
            {
                parentCageList.append(parentCageTextField.text!)
                print("     We added a parent cage")
                parentCageTableView.reloadData()
            }
        }else{
            print(parentCageTextField.text! + " is an invalid entry")
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
     * Displays a Date picker when the parentDOBTextField starts to be edited.
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == parentDOBTextField {
            /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
          
            let datePickerView:UIDatePicker = UIDatePicker()
            
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            textField.inputView = datePickerView
            
            datePickerView.addTarget(self, action:
                #selector(breedingCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    /**
     * Formats the date from the datepicker into the form dd/MM/YY.
     */
    func datePickerValueChanged(sender:UIDatePicker) {
       
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        dateFormatter.timeStyle = DateFormatter.Style.none
    
        parentDOBTextField.text = dateFormatter.string(from: sender.date)        
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return true
    }
   /***********************************************************************/
    
    
    
    
    
   /************************* TABLEVIEW FUNCTIONS *************************/
    
    /**
     * Determines the number of rows used for a tableView depending on which list it pulls data from.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.parentDOBTableView {
            count = parentDOBList.count
        }
        
        if tableView == self.parentCageTableView{
            count =  parentCageList.count
        }
        
        return count!
    }
    
    
    /**
     * Fills the tableView cells with data depeding on the list it pulls data from.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == self.parentDOBTableView{
            cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell")
            cell?.textLabel?.text = parentDOBList[indexPath.row]
        }
        
        if tableView == self.parentCageTableView{
            cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell1")
            cell?.textLabel?.text = parentCageList[indexPath.row]
        }
        return cell!
    }
    
   
    /**
     * Updates the TableView and list when being edited
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if tableView == self.parentDOBTableView{
            if editingStyle == UITableViewCellEditingStyle.delete {
                parentDOBList.remove(at: indexPath.row)
                parentDOBTableView.reloadData()
            }
        }
        
        if tableView == self.parentCageTableView{
            if editingStyle == UITableViewCellEditingStyle.delete {
                parentCageList.remove(at: indexPath.row)
                parentCageTableView.reloadData()
            }
        }
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
