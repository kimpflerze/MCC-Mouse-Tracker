//
//  addMaleViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftValidator

class AddMaleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ValidationDelegate {
    var wasValidationSuccessful = false
    
    // Validator Variable
    let validator = Validator()
    
    var parentCageIDList = [String]()
    var breedingMale: BreedingMale?
    var breedingMaleCurrentCage: Cage?
    var isNewMale = false
    var newMaleId: String?
    var hasTableViewChanged = false
    //Cage ID Scan (To give the Male an ID) = 0
    //Current Cage ID Scan = 1
    //Parent Cage ID Scan = 2
    var lastPressedScanButton = -1
    var maleInTheCage = false
    var originalMaleActiveState: Bool?
    
    var delegate: DetailViewControllerDelegate?
    
    //Images
    @IBOutlet weak var cageHasId: UIImageView!
    
    //TextFields
    @IBOutlet weak var rackNoTextField: UITextField!
    @IBOutlet weak var columnNoTextField: UITextField!
    @IBOutlet weak var rowNoTextField: UITextField!
    @IBOutlet weak var maleDOBTextField: UITextField!
    
    @IBOutlet weak var parentCageIDTextField: UITextField!

    //Buttons
    @IBOutlet weak var doneButton: UIButton!
//    @IBOutlet weak var addParentCageIDButton: UIButton!
    @IBOutlet weak var QRCodeButton: UIButton!

    
    //Switches
    @IBOutlet weak var maleActiveSwitch: UISwitch!
    
    //TableViews
    @IBOutlet weak var parentCageIDTableView: UITableView!
    
    //New additions
    @IBOutlet weak var parentCageIDScanButton: UIButton!
    @IBOutlet weak var currentCageIDScanButton: UIButton!
    @IBOutlet weak var currentCageIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        parentCageIDTableView.dataSource = self
        parentCageIDTableView.delegate = self
        
        //Toolbar to allow for dismissal of the picker views
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        //Assigning the toolbard created above to all of the textfields that use a pickerview.
        maleDOBTextField.inputAccessoryView = toolBar
        
        textfieldValidationRegistration()
        
        //Populate information from passed cage here!
        //Filling information for an existing cage
        if let theCage = breedingMaleCurrentCage {
            rackNoTextField.text = String(theCage.rack)
            columnNoTextField.text = String(theCage.column)
            rowNoTextField.text = String(theCage.row)
            
            maleInTheCage = theCage.maleInCage
            
            if(isNewMale == false) {
                //Disabling interaction with some textfields/buttons when working with an existing male
                parentCageIDScanButton.isUserInteractionEnabled = false
                parentCageIDTextField.isUserInteractionEnabled = false
                QRCodeButton.isUserInteractionEnabled = false
                
                guard let theMale = breedingMale else {
                    return
                }
                
                //Setting icon for indication of if cage has an ID set. Only relevant if its a new cage.
                if(theMale.id != "") {
                    cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
                }
                else {
                    cageHasId.image = #imageLiteral(resourceName: "XIcon")
                }
                
                //Setting the "active" switch to "off" if the cage is not an activly used cage.
                originalMaleActiveState = theMale.active
                if(theMale.active == false) {
                    maleActiveSwitch.setOn(false, animated: false)
                }
                
                maleDOBTextField.text = theMale.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a")
                
                for parentCage in theMale.motherCageIds {
                    parentCageIDList.append(parentCage)
                }
                parentCageIDTableView.reloadData()
                
                currentCageIDTextField.text = theMale.currentCageId
            }
            else {
                currentCageIDTextField.text = breedingMaleCurrentCage?.id
                currentCageIDScanButton.isUserInteractionEnabled = false
                cageHasId.image = #imageLiteral(resourceName: "XIcon")
            }
        }
    }
    
    @objc func donePicker() {
        self.view.endEditing(true)
    }
    
    func textfieldValidationRegistration() {
        //Register textfields for validation
        validator.registerField(maleDOBTextField, rules: [RequiredRule()])
        validator.registerField(rackNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rowNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(columnNoTextField, rules: [RequiredRule(), NumericRule()])
    }
    
    func validationSuccessful() {
        maleDOBTextField.layer.borderColor = UIColor.green.cgColor
        maleDOBTextField.layer.borderWidth = 1.0
        
        rackNoTextField.layer.borderColor = UIColor.green.cgColor
        rackNoTextField.layer.borderWidth = 1.0
        
        rowNoTextField.layer.borderColor = UIColor.green.cgColor
        rowNoTextField.layer.borderWidth = 1.0
        
        columnNoTextField.layer.borderColor = UIColor.green.cgColor
        columnNoTextField.layer.borderWidth = 1.0
        
        wasValidationSuccessful = true
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        // turn the fields to red
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
        }
        wasValidationSuccessful = false

    }
    
    func hasInformationChanged() -> Bool {
        guard let theCage = breedingMaleCurrentCage else {
            return false
        }
        if originalMaleActiveState != self.breedingMale?.active || rackNoTextField.text != String(theCage.rack) || columnNoTextField.text != String(theCage.column) || rowNoTextField.text != String(theCage.row) || currentCageIDTextField.text != String(theCage.id) || maleDOBTextField.text != breedingMale?.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a") {
            return true
        }
        return hasTableViewChanged
    }
    
    @IBAction func pressedQRCodeButton(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner") as? QRScannerController {
            lastPressedScanButton = 0
            qrVC.delegate = self
            present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressedDoneButton(_ sender: UIButton) {
        let doneButtonPressedAlert = UIAlertController(title: "Are you sure?", message: "What would you like to do?", preferredStyle: .alert)
        let continueWithoutSavingAction = UIAlertAction(title: "Continue Without Saving", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let continueAndSaveAction = UIAlertAction(title: "Save and Continue", style: .default) { (action) in
            self.validator.validate(self)
            
            if self.wasValidationSuccessful {
                
                //Depending on if isNewCage is true or false, will either update or insert into the database
                if(self.isNewMale) {
                    //New male, insert into database
                    let doneButtonHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                    doneButtonHUD.detailsLabel.text = "Sending information..."
                    QueryServer.shared.createNewBreedingMale(id: self.newMaleId, isActive: 1, motherCageId: self.parentCageIDList.first, DOB: self.maleDOBTextField.text, currentCageId: self.currentCageIDTextField.text, completion: { (error) in
                        doneButtonHUD.hide(animated: true)
                        self.delegate?.detailViewControllerDidSave(controller: self)
                    })
                }
                else {
                    //Existing cage, update its information
                    if(!self.hasInformationChanged()) {
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        let updateConfirmAlert = UIAlertController(title: "Confirm Update", message: "Cage information has been changed, do you wish to save these changes?", preferredStyle: .alert)
                        let confirmUpdateAction  = UIAlertAction(title: "Confirm", style: .default, handler: { (placeholder) in
                            let updateHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                            updateHUD.detailsLabel.text = "Updating database information..."
                            //Temporary variable used just for passing correct information to the QueryServer.shared.updateBreedingCageWith(id:)
                            var numericalStringCageIsActive = ""
                            if(self.breedingMale?.active == true) {
                                numericalStringCageIsActive = "1"
                            }
                            else {
                                numericalStringCageIsActive = "0"
//                                breedingMaleCurrentCage.  // LEFT OFF HERE, NEED TO MAKE IT SO BREEDING CAGE DOESNT RECOGNIZE BREEDING MALE ANYMORE
                            }
                            
                            QueryServer.shared.updateBreedingMaleWith(id: self.breedingMale?.id, isActive: numericalStringCageIsActive, currentCageId: self.currentCageIDTextField.text, dob: self.maleDOBTextField.text, completion: { (response) in
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
        }
        
        doneButtonPressedAlert.addAction(continueWithoutSavingAction)
        doneButtonPressedAlert.addAction(continueAndSaveAction)
        doneButtonPressedAlert.addAction(cancelAction)
        present(doneButtonPressedAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func maleDOBEditing(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(breedingCageViewController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func currentCageIDScanButtonPressed(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner") as? QRScannerController {
            lastPressedScanButton = 1
            qrVC.delegate = self
            present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func parentCageIDScanButtonPressed(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner") as? QRScannerController {
            lastPressedScanButton = 2
            qrVC.delegate = self
            present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func maleActiveSwitchFlipped(_ sender: UISwitch) {
        if maleActiveSwitch.isOn {
            self.breedingMale?.active = true
        }
        else {
            let activeSwitchAlert = UIAlertController(title: "Warning!", message: "Are you sure you wish to deactivate this cage?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (sender) in
                self.breedingMale?.active = false
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (sender) in
                self.maleActiveSwitch.setOn(true, animated: true)
            })
            activeSwitchAlert.addAction(confirmAction)
            activeSwitchAlert.addAction(cancelAction)
            self.present(activeSwitchAlert, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var result = true
        validator.validateField(textField){ error in
            if error == nil {
                // Field validation was successful
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
                result = true
            } else {
                // Validation error occurred
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
     * Displays a Date picker when the parentCageIDTextField
     * starts to be edited.
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
        
        if textField == maleDOBTextField {
            let datePickerView:UIDatePicker = UIDatePicker()
            
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            textField.inputView = datePickerView
            
            datePickerView.addTarget(self, action: #selector(breedingCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        maleDOBTextField.text = sender.date.toString(withFormat: "MM-dd-yyyy hh:mm:ss a")
    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        parentCageIDTableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? CageAlertsViewController {
            destinationVC.cageAlertArray = (breedingMaleCurrentCage?.alerts)!
        }
    }
    /*************************** VALIDATION RULES **************************/
    
    /**
     * Matches dates with format MM-dd-yyyy hh:mm:ss a
     */
    class ValidDateRule: RegexRule {
        
        static let regex = "^([1-9]|([012][0-9])|(3[01]))-([0]{0,1}[1-9]|1[012])-\\d\\d\\d\\d\\s[012]{0,1}[0-9]:[0-6][0-9]:[0-6][0-9]\\s(AM|am|PM|pm)$"
        
        convenience init(message : String = "Not a valid date (format: MM-dd-yyyy hh:mm:ss a)"){
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
    
}
extension AddMaleViewController: QRScannerControllerDelegate {
    func qrScannerController(controller: QRScannerController, didScanQRCodeWith value: String) {

        controller.dismiss(animated: true) {
            //Find the cage object
            if(self.lastPressedScanButton == 2) {
                self.parentCageIDList.append(value)
                self.parentCageIDTableView.reloadData()
                self.hasTableViewChanged = true
                QueryServer.shared.getBreedingCageBy(id: value, completion: { (cage, error) in
                    if let theLitterDOB = cage?.litterDOB {
                        self.maleDOBTextField.text = theLitterDOB.toString(withFormat: "MM-dd-yyyy hh:mm:ss a")
                    }
                })
                
            }
            else if (self.lastPressedScanButton == 1){
            //Attempt to update breeding male current cage information
                //Query for cage with the scanned ID and store it
                QueryServer.shared.getBreedingCageBy(id: value, completion: { (cage, error) in
                    if(cage != nil) {
                        //Attempt to move the male to new cage, if male in cage or one degree separation violated, fail to move male
                        if self.maleInTheCage == true {
                            let alert = UIAlertController(title: "Male Exists!", message: "This cage already contains a male!", preferredStyle: .alert)
                            let confirm = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                            alert.addAction(confirm)
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                        else {
                            if self.isNewMale {
                                self.currentCageIDTextField.text = value
                                return
                            }
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.detailsLabel.text = "Moving male..."
                            QueryServer.shared.updateBreedingMaleWith(id: self.breedingMale?.id, isActive: nil, currentCageId: value, dob: self.breedingMale?.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"), completion: { (error) in
                                hud.hide(animated: true)
                                if let errorMessage = error {
                                    let alert = UIAlertController(title: "Error!", message: "There was an error moving this male: \(errorMessage)", preferredStyle: .alert)
                                    let confirm = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                                    alert.addAction(confirm)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                }
                                else {
                                    let alert = UIAlertController(title: "Moved Male Successfully!", message: "This male has been moved to cage ID: \(cage?.id ?? "")", preferredStyle: .alert)
                                    let confirm = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                                    alert.addAction(confirm)
                                    self.currentCageIDTextField.text = value
                                    self.present(alert, animated: true, completion: nil)
                                }
                            })
                        }
                    }
                })
            }
            else {
                self.newMaleId = value
                self.cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
            }
            
        }
    }
}

extension AddMaleViewController : RackViewControllerDelegate {
    func rackViewController(controller: RackViewController, didSelectCage cage: Cage?) {
        controller.dismiss(animated: true) {
            if cage?.maleInCage == true {
                let alert = UIAlertController(title: "Male Exists!", message: "This cage already contains a male!", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(confirm)
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.detailsLabel.text = "Moving male..."
                QueryServer.shared.updateBreedingMaleWith(id: self.breedingMale?.id, isActive: nil, currentCageId: cage?.id, dob: self.breedingMale?.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"), completion: { (error) in
                hud.hide(animated: true)
                if let errorMessage = error {
                    let alert = UIAlertController(title: "Error!", message: "There was an error moving this male: \(errorMessage)", preferredStyle: .alert)
                    let confirm = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(confirm)
                    
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Moved Male Successfully!", message: "This male has been moved to cage ID: \(cage?.id ?? "")", preferredStyle: .alert)
                    let confirm = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(confirm)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            })
            }
        }
    }
}
