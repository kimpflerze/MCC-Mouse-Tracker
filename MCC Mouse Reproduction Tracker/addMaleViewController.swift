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

class addMaleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ValidationDelegate {
    var wasValidationSuccessful = false
    
    // Validator Variable
    let validator = Validator()
    
    var parentCageIDList = [String]()
    var breedingMale: BreedingMale?
    var breedingMaleCurrentCage: Cage?
    var isNewMale = false
    var newMaleId: String?
    var hasTableViewChanged = false
    
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
    @IBOutlet weak var addParentCageIDButton: UIButton!
    @IBOutlet weak var QRCodeButton: UIButton!
    @IBOutlet weak var moveMaleButton: UIButton!
    
    //TableViews
    @IBOutlet weak var parentCageIDTableView: UITableView!
    
    //New additions
    @IBOutlet weak var parentCageIDScanButton: UIButton!
    @IBOutlet weak var currentCageIDScanButton: UIButton!
    @IBOutlet weak var currentCageIDTextField: UITextField!
    
    //Parent Cage ID Scan = 0
    //Current Cage ID Scan = 1
    var lastPressedScanButton = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("[TO-DO] Complete inserting information for existing breeding males in addMaleViewController.swift")
        
        parentCageIDTableView.dataSource = self
        parentCageIDTableView.delegate = self
        
        textfieldValidationRegistration()
        
        //Populate information from passed cage here!
        //Filling informatin for an existing cage
        if let theCage = breedingMaleCurrentCage {
            rackNoTextField.text = String(theCage.rack)
            columnNoTextField.text = String(theCage.column)
            rowNoTextField.text = String(theCage.row)
            
            if(isNewMale == false) {
                guard let theMale = breedingMale else {
                    return
                }
                maleDOBTextField.text = theMale.dob?.toString()
                
                for parentCage in theMale.motherCageIds {
                    parentCageIDList.append(parentCage)
                }
                parentCageIDTableView.reloadData()
                
                currentCageIDTextField.text = theMale.currentCageId
            }
        }
    }
    
    func textfieldValidationRegistration() {
        //Register textfields for validation
        validator.registerField(parentCageIDTextField, rules: [RequiredRule(),NumericRule()])
        validator.registerField(maleDOBTextField, rules: [RequiredRule(),ValidDateRule()])
        validator.registerField(rackNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rowNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(columnNoTextField, rules: [RequiredRule(), NumericRule()])
    }
    
    func validationSuccessful() {
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
        
        wasValidationSuccessful = true
        print("textField validation successful!!")
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
        print("textField validation failed!!")
    }
    
    func hasInformationChanged() -> Bool {
        guard let theCage = breedingMaleCurrentCage else {
            return false
        }
        if rackNoTextField.text != String(theCage.rack) || columnNoTextField.text != String(theCage.column) || rowNoTextField.text != String(theCage.row) || currentCageIDTextField.text != String(theCage.id){
            return true
        }
        return hasTableViewChanged
    }
    
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner")
            as? QRScannerController {
            lastPressedScanButton = 0
            qrVC.delegate = self
            present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressed_done_btn(_ sender: UIButton) {
        print("[TO-DO] Complete pushing new information to database in addMaleViewController.swift")
        validator.validate(self)
        
        if wasValidationSuccessful {
            if(isNewMale) {
                //New male, insert into database
                let doneButtonHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                doneButtonHUD.detailsLabel.text = "Sending information..."
                QueryServer.shared.createNewBreedingMale(id: newMaleId, isActive: 1, motherCageId: parentCageIDList[0], DOB: maleDOBTextField.text, currentCageId: breedingMaleCurrentCage?.id, completion: { (error) in
                    debugPrint(error)
                    doneButtonHUD.hide(animated: true)
                    self.delegate?.detailViewControllerDidSave(controller: self)
                })
            }
            else {
                //Existing cage, update its information
                if(!hasInformationChanged() || !(wasValidationSuccessful)) {
                    dismiss(animated: true, completion: nil)
                }
                else {
                    let updateConfirmAlert = UIAlertController(title: "Confirm Update", message: "Cage information has been changed, do you wish to save these changes?", preferredStyle: .alert)
                    let confirmUpdateAction  = UIAlertAction(title: "Confirm", style: .default, handler: { (placeholder) in
                        let updateHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                        updateHUD.detailsLabel.text = "Updating database information..."
                        QueryServer.shared.updateBreedingMaleWith(id: self.breedingMale?.id, isActive: nil, currentCageId: self.currentCageIDTextField.text, completion: { (response) in
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
        // Depending on if isNewCage is true or false, will either update or insert into the database
        
        // dismiss(animated: true, completion: nil)
    }
    
    
    /*Depreciated? we use the QR scanner */
    /*@IBAction func pressed_addParentCageIDButton(_ sender: UIButton) {
        print("pressed add parent cage ID button")
        
        if(parentCageIDTextField.text != "")
        {
            parentCageIDList.append(parentCageIDTextField.text!)
            print("     We added a parent cage ID!")
            parentCageIDTableView.reloadData()
        }
    }*/
    
    @IBAction func maleDOBEditing(_ sender: UITextField) {
        
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(breedingCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
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
    
    @IBAction func moveMaleButtonPressed(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let rackVC = mainStoryboard.instantiateViewController(withIdentifier: "RackVC") as? RackViewController {
            
            rackVC.delegate = self
            self.present(rackVC, animated: true, completion: nil)
            
        }
        
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
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateStyle = DateFormatter.Style.long
//
//        dateFormatter.timeStyle = DateFormatter.Style.long
        
        maleDOBTextField.text = sender.date.toString()
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
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
    
}
extension addMaleViewController: QRScannerControllerDelegate {
    func qrScannerController(controller: QRScannerController, didScanQRCodeWith value: String) {
        print("ID Recieved from Scanner! Id: \(value)")
        controller.dismiss(animated: true) {
            //Find the cage object
            if(self.lastPressedScanButton == 0) {
                self.parentCageIDList.append(value)
                self.parentCageIDTableView.reloadData()
                self.hasTableViewChanged = true
            }
            else if (self.lastPressedScanButton == 1){
                self.currentCageIDTextField.text = value
            }
            else {
                self.newMaleId = value
                self.cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
            }
            
        }
    }
}

extension addMaleViewController : RackViewControllerDelegate {
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
            QueryServer.shared.updateBreedingMaleWith(id: self.breedingMale?.id, isActive: nil, currentCageId: cage?.id, completion: { (error) in
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
