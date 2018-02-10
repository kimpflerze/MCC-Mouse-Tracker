//
//  stockCageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftValidator

class stockCageViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ValidationDelegate {
    var wasValidationSuccessful = false
    
    // Validator Variable
    let validator = Validator()
    
    var stockCageDOBList = [String]()
    var stockCageParentCageIdList = [String]()
    
    //Variables for the current view to operate
    var cage: Cage?
    var isNewCage = false
    var hasTableViewChanged = false
    var newCageId: String?
    var genderFlag = 0;
    
    var delegate: DetailViewControllerDelegate?
    
    //Images
    @IBOutlet weak var cageHasId: UIImageView!
    
    //TextLabel
    @IBOutlet weak var genderFlagTextLabel: UILabel!
    @IBOutlet weak var stockCageViewTitleLabel: UILabel!
    
    
    //TextFields
    @IBOutlet weak var rackNoTextField: UITextField!
    @IBOutlet weak var columnNoTextField: UITextField!
    @IBOutlet weak var rowNoTextField: UITextField!
    @IBOutlet weak var miceCountTextField: UITextField!
    @IBOutlet weak var stockCageDOBTextField: UITextField!
    
    //SegmentedControls
    @IBOutlet weak var genderFlagSegmentControl: UISegmentedControl!
    
    //Buttons
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addDOBButton: UIButton!
    @IBOutlet weak var QRCodeButton: UIButton!
    
    //TableViews
    @IBOutlet weak var stockCageDOBTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("[TO-DO] Add/fix button to allow setting DOB of mice int he cage!")
        
        stockCageDOBTableView.dataSource = self
        stockCageDOBTableView.delegate = self
        
        //Register textfields for validation
        validator.registerField(stockCageDOBTextField, rules: [RequiredRule(),ValidDateRule()])
        validator.registerField(miceCountTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rackNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rowNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(columnNoTextField, rules: [RequiredRule(), NumericRule()])
        
//        view.bringSubview(toFront: stockCageViewTitleLabel)
        
        //Checking if the cage being manipulated is a new one or existing
        
        //Filling information for an existing cage
        if let theCage = cage {
            //Filling information into stockCageParentCageIdList in preparation for POST statement
            for parentCage in theCage.parentCages {
                stockCageParentCageIdList.append(parentCage.currentCageId)
            }
            
            //Autofilling text fields
            rackNoTextField.text = String(theCage.rack)
            columnNoTextField.text = String(theCage.column)
            rowNoTextField.text = String(theCage.row)
            
            if(isNewCage == false) {
                miceCountTextField.text = String(theCage.numMice)
                
                if(theCage.id != "" || theCage.id != nil) {
                    cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
                }
                else {
                    cageHasId.image = #imageLiteral(resourceName: "XIcon")
                }
                
                if (theCage.isMaleOnlyCage)! {
                    genderFlagSegmentControl.selectedSegmentIndex = 0
                }
                else {
                    genderFlagSegmentControl.selectedSegmentIndex = 1
                }
                
                for parentCage in theCage.parentCages {
                    if let dateAsString = parentCage.dob?.toString() {
                        if(stockCageDOBList.contains(dateAsString) == false) {
                            stockCageDOBList.append(dateAsString)
                            stockCageDOBTableView.reloadData()
                        }
                    }
                }
                
                /*
                 let formatter = DateFormatter()
                 formatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
                 if var dateString = parentInfo["DOB"] as? String {
                 if let theDob = formatter.date(from: dateString) {
                 dob = theDob
                 }
                 }
 */
                
                
                
            }
        }
    }
    
    func validationSuccessful(){
        /* save textfield information database */
        stockCageDOBTextField.layer.borderColor = UIColor.green.cgColor
        stockCageDOBTextField.layer.borderWidth = 1.0
        
        miceCountTextField.layer.borderColor = UIColor.green.cgColor
        miceCountTextField.layer.borderWidth = 1.0
        
        rackNoTextField.layer.borderColor = UIColor.green.cgColor
        rackNoTextField.layer.borderWidth = 1.0
        
        rowNoTextField.layer.borderColor = UIColor.green.cgColor
        rowNoTextField.layer.borderWidth = 1.0
        
        columnNoTextField.layer.borderColor = UIColor.green.cgColor
        columnNoTextField.layer.borderWidth = 1.0
        
        print("textField validation successful!!")
        
        /* SAVE DATA TO DATABASE AND DIRECT USER TO PROPER VIEW HERE */
    }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func genderFlagSegmentedControlTapped(_ sender: UISegmentedControl) {
        if(genderFlagSegmentControl.selectedSegmentIndex == 0) {
            print("Gender Flag: Male")
            genderFlag = 1
        }
        else {
            print("Gender Flag: Female")
            genderFlag = 0
        }
        
    }
    
    
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner") as? QRScannerController {
            qrVC.delegate = self
            present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressed_done_btn(_ sender: UIButton) {
        print("[TO-DO] Complete pushing new information to database in stockCageViewController.swift")
        print("[TO_DO] Complete idiot proofing for done button in stockCageViewController.swift")
        
        validator.validate(self)
        
        //Depending on if isNewCage is true or false, will either update or insert into the database
        if(isNewCage) {
            //New cage, insert into database
            let doneButtonHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            doneButtonHUD.detailsLabel.text = "Sending information..."
            QueryServer.shared.createNewSellingCage(id: newCageId, row: Int(rowNoTextField.text!), column: Int(columnNoTextField.text!), rack: Int(rackNoTextField.text!), isActive: 1, parentsCagesDOB: stockCageDOBList, parentCagesId: stockCageParentCageIdList, gender: genderFlag, numberOfMice: Int(miceCountTextField.text!), completion: { (error) in
                debugPrint(error)
                doneButtonHUD.hide(animated: true)
                self.delegate?.detailViewControllerDidSave(controller: self)
            })
        }
        else {
            //Existing cage, update its information
            if (!hasInformationChanged() || !(wasValidationSuccessful)) {
                dismiss(animated: true, completion: nil)
            }
            else {
                let updateConfirmAlert = UIAlertController(title: "Confirm Update", message: "Cage information has been changed, do you wish to save these changes?", preferredStyle: .alert)
                let confirmUpdateAction  = UIAlertAction(title: "Confirm", style: .default, handler: { (placeholder) in
                    let updateHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                    updateHUD.detailsLabel.text = "Updating database information..."
                    QueryServer.shared.updateSellingCageWith(id: self.cage?.id, row: self.rowNoTextField.text, column: self.columnNoTextField.text, rack: self.rackNoTextField.text, isActive: nil, numberOfMice: self.miceCountTextField.text, completion: { (response) in
                        updateHUD.hide(animated: true)
                        let updateAlert = UIAlertController(title: "Update Cage", message: "The cage information was successfully udpated!", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (response) in
                            self.delegate?.detailViewControllerDidSave(controller: self)
                        })
                        updateAlert.addAction(confirmAction)
                        self.present(updateAlert, animated: true, completion: nil)
                        
                    })
                })
                let cancelUpdateAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                updateConfirmAlert.addAction(confirmUpdateAction)
                updateConfirmAlert.addAction(cancelUpdateAction)
                self.present(updateConfirmAlert, animated: true, completion: nil)
            }
            
        }

    }
    
    func hasInformationChanged() -> Bool {
        guard let theCage = cage else {
            return false
        }
        if rackNoTextField.text != String(theCage.rack) || columnNoTextField.text != String(theCage.column) || rowNoTextField.text != String(theCage.row) {
            return true
        }
        return hasTableViewChanged
    }
    
    @IBAction func pressed_addStockCageDOBButton(_ sender: UIButton) {
        print("pressed add stock cage DOB button")
        
        if(stockCageDOBTextField.text != "")
        {
            stockCageDOBList.append(stockCageDOBTextField.text!)
            print("     We added a stock cage DOB")
            stockCageDOBTableView.reloadData()
        }
    }
    
    @IBAction func addStockCageDOBEditing(_ sender: UITextField) {
        
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(breedingCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        stockCageDOBTextField.text = dateFormatter.string(from: sender.date)
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockCageDOBList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell")
            cell.textLabel?.text = stockCageDOBList[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == UITableViewCellEditingStyle.delete {
       stockCageDOBList.remove(at: indexPath.row)
       stockCageDOBTableView.reloadData()}
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        stockCageDOBTableView.reloadData()
    }

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
     * When the user clears the input using the clear button
     * the border the textfield is set to its default
     * design.
     */
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return true
    }
    
    /**
     * Displays a Date picker when the stockCageDOBTextField
     * starts to be edited.
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
        
        if textField == stockCageDOBTextField {
            let datePickerView:UIDatePicker = UIDatePicker()
            
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            textField.inputView = datePickerView
            
            datePickerView.addTarget(self, action: #selector(breedingCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    /*************************** VALIDATION RULES **************************/
    
    /**
     * Matches dates with either format M/dd/yy or MM/dd/yy
     * i.e) 7/10/17 or 07/10/17
     */
    class ValidDateRule: RegexRule {
        
        static let regex = "^([1-9]|0[1-9]|1[012])[/](0[1-9]|[12][0-9]|3[01])[/]\\d\\d$"
        
        convenience init(message : String = "Not a valid date (format: MM/dd/yy or M/dd/yy)"){
            self.init(regex: ValidDateRule.regex, message : message)
        }
    }
    
    /**
     * Matches any number of length 1 or greater that does
     * not have a leading zero
     */
    class NumericRule: RegexRule {
        
        static let regex = "^[1-9][0-9]*"
        
        convenience init(message : String = "Not a valid number"){
            self.init(regex: NumericRule.regex, message : message)
        }
    }
    /***********************************************************************/

}

extension stockCageViewController: QRScannerControllerDelegate {
    func qrScannerController(controller: QRScannerController, didScanQRCodeWith value: String) {
        print("ID Recieved from Scanner! Id: \(value)")
        controller.dismiss(animated: true) {
            //Find the cage object
            self.newCageId = value
            self.cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
        }
    }
}
