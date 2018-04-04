//
//  stockCageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.


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
    var originalCageActiveState: Bool?
    var originalCageGenderWasMale: Bool?
    var dobInCageListWasAltered = false
    
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
    @IBOutlet weak var QRCodeButton: UIButton!
    
    //TableViews
    @IBOutlet weak var stockCageDOBTableView: UITableView!
    
    //Switches
    @IBOutlet weak var cageActiveSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stockCageDOBTableView.dataSource = self
        stockCageDOBTableView.delegate = self
        
        //Toolbar to allow for dismissal of the picker views
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let addDateButton = UIBarButtonItem(title: "Add Date", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addDateToDOBTableView))
        toolBar.setItems([doneButton, addDateButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        //Assigning the toolbard created above to all of the textfields that use a pickerview.
        stockCageDOBTextField.inputAccessoryView = toolBar
        
        //Register textfields for validation
        validator.registerField(stockCageDOBTextField, rules: [/*RequiredRule(),*/ValidDateRule()])
        validator.registerField(miceCountTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rackNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rowNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(columnNoTextField, rules: [RequiredRule(), NumericRule()])
        
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
            stockCageDOBTextField.text = (String(describing: theCage.createdAt.toString(withFormat: "MM-dd-yyyy hh:mm:ss a")))
  
            
            if(isNewCage == false) {
                //Setting the "active" switch to "off" if the cage is not an activly used cage.
                originalCageActiveState = theCage.isActive
                originalCageGenderWasMale = theCage.isMaleOnlyCage
                if(theCage.isActive == false) {
                    cageActiveSwitch.setOn(false, animated: false)
                }
                
                miceCountTextField.text = String(theCage.numMice)
                
                if(theCage.id != "") {
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
                }}}}
            else {
                cageHasId.image = #imageLiteral(resourceName: "XIcon")
            }}}
    
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
        
        wasValidationSuccessful = true
        //print("textField validation successful!!")
        
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
        wasValidationSuccessful = false
        //print("textField validation failed!!")
    }
    
    @objc func donePicker() {
        self.view.endEditing(true)
    }
    
    @objc func addDateToDOBTableView() {
        print("***In addDateToDOBTableView function!")
        if stockCageDOBTextField.text != "" || stockCageDOBTextField.text != nil {
            print("***1")
            if let date = stockCageDOBTextField.text {
                print("***2 : \(date)")
                dobInCageListWasAltered = true
                stockCageDOBList.append(date)
                stockCageDOBTableView.reloadData()
            }
        }
    }
    
    @IBAction func genderFlagSegmentedControlTapped(_ sender: UISegmentedControl) {
        if(genderFlagSegmentControl.selectedSegmentIndex == 0) {
            //print("Gender Flag: Male")
            genderFlag = 1
        }
        else {
            //print("Gender Flag: Female")
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
        validator.validate(self)

        if wasValidationSuccessful {
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
                if (!hasInformationChanged() /*|| wasValidationSuccessful)*/) {
                    //print("Dismissed existing stock cage without pushing new changes! \(!hasInformationChanged())")
                    dismiss(animated: true, completion: nil)
                }
                else {
                    self.stockCageDOBList.append(stockCageDOBTextField.text!)
                    let updateConfirmAlert = UIAlertController(title: "Confirm Update", message: "Cage information has been changed, do you wish to save these changes?", preferredStyle: .alert)
                    let confirmUpdateAction  = UIAlertAction(title: "Confirm", style: .default, handler: { (placeholder) in
                        let updateHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                        updateHUD.detailsLabel.text = "Updating database information..."
                        //Temporary variable used just for passing correct information to the QueryServer.shared.updateBreedingCageWith(id:)
                        var numericalStringCageIsActive = ""
                        if(self.cage?.isActive == true) {
                            numericalStringCageIsActive = "1"
                        }
                        else {
                            numericalStringCageIsActive = "0"
                        }
                        QueryServer.shared.updateSellingCageWith(id: self.cage?.id, row: self.rowNoTextField.text, column: self.columnNoTextField.text, rack: self.rackNoTextField.text, isActive: numericalStringCageIsActive, numberOfMice: self.miceCountTextField.text, genderOfMice: String(self.genderFlag), cageIdList: self.stockCageParentCageIdList, cageDOBList: self.stockCageDOBList, completion: { (response) in
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
    } //end pressed_done_btn()
    
    func hasInformationChanged() -> Bool {
        guard let theCage = cage else {
            return false
        }

        if originalCageActiveState != self.cage?.isActive || rackNoTextField.text != String(theCage.rack) || columnNoTextField.text != String(theCage.column) || rowNoTextField.text != String(theCage.row) ||
            miceCountTextField.text != String(theCage.numMice) ||
            (originalCageGenderWasMale! && genderFlagSegmentControl.selectedSegmentIndex == 0) ||
            dobInCageListWasAltered {
            print("Something didnt match!")
            return true
        }
        return hasTableViewChanged
    }
    
    @IBAction func addStockCageDOBEditing(_ sender: UITextField) {
        
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(stockCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func cageActiveSwitchFlipped(_ sender: UISwitch) {
        if cageActiveSwitch.isOn {
            self.cage?.isActive = true
        }
        else {
            let activeSwitchAlert = UIAlertController(title: "Warning!", message: "Are you sure you wish to deactivate this cage?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (sender) in
                self.cage?.isActive = false
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (sender) in
                self.cageActiveSwitch.setOn(true, animated: true)
            })
            activeSwitchAlert.addAction(confirmAction)
            activeSwitchAlert.addAction(cancelAction)
            self.present(activeSwitchAlert, animated: true, completion: nil)
        }
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateStyle = DateFormatter.Style.long
//
//        dateFormatter.timeStyle = DateFormatter.Style.none
        
        stockCageDOBTextField.text = sender.date.toString(withFormat: "MM-dd-yyyy hh:mm:ss a")
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
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var result = true
        validator.validateField(textField){ error in
            if error == nil {
                // Field validation was successful
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
                //print("textField validation successful!!")
                result = true
            } else {
                // Validation error occurred
               //print(error?.errorMessage ?? textField.text! + "is an invalid entry")
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

            datePickerView.addTarget(self, action: #selector(stockCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        stockCageDOBTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? CageAlertsViewController {
            destinationVC.cageAlertArray = (cage?.alerts)!
        }
    }
    
    /*************************** VALIDATION RULES **************************/
    
    /**
     * Matches dates with format MM-dd-yyyy hh:mm:ss a
     */
    class ValidDateRule: RegexRule {
        
        static let regex = "^([1-9]|([012][0-9])|(3[01]))-([0]{0,1}[1-9]|1[012])-\\d\\d\\d\\d\\s[012]{0,1}[0-9]:[0-6][0-9]:[0-6][0-9]\\s(AM|am|PM|pm)$"
        //"^([1-9]|0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])[-](\\d\\d\\d\\d)\\s([0-9][0-9])[:]([0-5][0-9])[:]([0-5][0-9])\\s(AM|PM)$"
        
        convenience init(message : String = "Not a valid date (format: MM-dd-yyyy hh:mm:ss a)"){
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
        //print("ID Recieved from Scanner! Id: \(value)")
        controller.dismiss(animated: true) {
            //Find the cage object
            self.newCageId = value
            self.cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
        }
    }
}
