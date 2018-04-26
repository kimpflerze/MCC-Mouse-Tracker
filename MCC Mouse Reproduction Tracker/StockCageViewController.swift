//
//  stockCageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.


import UIKit
import MBProgressHUD
import SwiftValidator

class StockCageViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ValidationDelegate {
    var wasValidationSuccessful = false
    
    // Validator Variable
    let validator = Validator()
    
    var stockCageDOBList = [String]()
    var stockCageNewDOBList = [String]()
    var stockCageIDList = [String]()
    
    //Variables for the current view to operate
    var cage: Cage?
    var isNewCage = false
    var hasTableViewChanged = false
    var newCageId: String?
    var genderFlag = 0;
    var originalCageActiveState: Bool?
    var originalCageGenderWasMale: Bool?
    var hasDOBListBeenAltered = false
    var wasSetIdScanButtonPressedLast = false
    
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
    @IBOutlet weak var scanDOBButton: UIButton!
    
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
        validator.registerField(miceCountTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rackNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rowNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(columnNoTextField, rules: [RequiredRule(), NumericRule()])
        
        //Filling information for an existing cage
        if let theCage = cage {
            //Filling information into stockCageParentCageIdList in preparation for POST statement
            for parentCage in theCage.parentCages {
                stockCageIDList.append(parentCage.id)
                stockCageDOBList.append((parentCage.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))!)
            }
            
            //Autofilling text fields
            rackNoTextField.text = String(theCage.rack)
            columnNoTextField.text = String(theCage.column)
            rowNoTextField.text = String(theCage.row)
            
            if(isNewCage == false) {
                //Disabling interaction with some buttons for existing cages
                QRCodeButton.isUserInteractionEnabled = false
                
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
                    if let dateAsString = parentCage.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a") {
                        if(stockCageDOBList.contains(dateAsString) == false) {
                            stockCageDOBList.append(dateAsString)
                            stockCageIDList.append(parentCage.id)
                            stockCageDOBTableView.reloadData()
                }}}}
            else {
                cageHasId.image = #imageLiteral(resourceName: "XIcon")
            }}}
    
    func validationSuccessful(){
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
    }
    
    @objc func donePicker() {
        self.view.endEditing(true)
    }
    
    @objc func addDateToDOBTableView() {
        if stockCageDOBTextField.text != "" || stockCageDOBTextField.text != nil {
            if let date = stockCageDOBTextField.text {
                hasDOBListBeenAltered = true
                stockCageDOBTextField.text = nil
                stockCageDOBList.append(date)
                stockCageDOBTableView.reloadData()
            }
        }
    }
    
    @IBAction func genderFlagSegmentedControlTapped(_ sender: UISegmentedControl) {
        if(genderFlagSegmentControl.selectedSegmentIndex == 0) {
            genderFlag = 1
        }
        else {
            genderFlag = 0
        }
    }
    
    
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        wasSetIdScanButtonPressedLast = true
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner") as? QRScannerController {
            qrVC.delegate = self
            present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressedScanDOBButton(_ sender: UIButton) {
        wasSetIdScanButtonPressedLast = false
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner") as? QRScannerController {
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
                if(self.isNewCage) {
                    //New cage, insert into database
                    let doneButtonHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                    doneButtonHUD.detailsLabel.text = "Sending information..."
                    if self.stockCageDOBList.count > 0 {
                        QueryServer.shared.createNewSellingCage(id: self.newCageId, row: Int(self.rowNoTextField.text!), column: Int(self.columnNoTextField.text!), rack: Int(self.rackNoTextField.text!), isActive: 1, parentsCagesDOB: self.stockCageDOBList, parentCagesId: self.stockCageIDList, gender: self.genderFlag, numberOfMice: Int(self.miceCountTextField.text!), completion: { (error) in
                            doneButtonHUD.hide(animated: true)
                            self.delegate?.detailViewControllerDidSave(controller: self)
                        })
                    }
                    else {
                        let noDOBAlert = UIAlertController(title: "No DOBs Provided", message: "Please input DOBs for this cage's mice!", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        noDOBAlert.addAction(cancelAction)
                        self.present(noDOBAlert, animated: true, completion: nil)
                    }
                }
                else {
                    //Existing cage, update its information
                    if (!self.hasInformationChanged() /*|| wasValidationSuccessful)*/) {
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
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
                            QueryServer.shared.updateSellingCageWith(id: self.cage?.id, row: self.rowNoTextField.text, column: self.columnNoTextField.text, rack: self.rackNoTextField.text, isActive: numericalStringCageIsActive, numberOfMice: self.miceCountTextField.text, genderOfMice: String(self.genderFlag), cageIdList: self.stockCageIDList, cageDOBList: self.stockCageDOBList, completion: { (response) in
                                if self.hasDOBListBeenAltered {
                                    QueryServer.shared.updateSellingCageDOBsWith(id: self.cage?.id, dobs: self.stockCageNewDOBList, completion: { (error) in
                                        self.presentCageUpdatedAlert(hud: updateHUD)
                                    })
                                }
                                else {
                                    self.presentCageUpdatedAlert(hud: updateHUD)
                                }
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
    
    func presentCageUpdatedAlert(hud: MBProgressHUD) {
        hud.hide(animated: true)
        let updateAlert = UIAlertController(title: "Update Cage", message: "The cage information was successfully udpated!", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (response) in
            self.delegate?.detailViewControllerDidSave(controller: self)
        })
        updateAlert.addAction(confirmAction)
        self.present(updateAlert, animated: true, completion: nil)
    }
    
    func hasInformationChanged() -> Bool {
        guard let theCage = cage else {
            return false
        }

        if originalCageActiveState != self.cage?.isActive || rackNoTextField.text != String(theCage.rack) || columnNoTextField.text != String(theCage.column) || rowNoTextField.text != String(theCage.row) ||
            miceCountTextField.text != String(theCage.numMice) ||
            (originalCageGenderWasMale! && genderFlagSegmentControl.selectedSegmentIndex == 0) ||
            hasDOBListBeenAltered {
            return true
        }
        return hasTableViewChanged
    }
    
    @IBAction func addStockCageDOBEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(StockCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
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
        stockCageDOBTextField.text = sender.date.toString(withFormat: "MM-dd-yyyy hh:mm:ss a")
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
           stockCageDOBTableView.reloadData()
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
     * Displays a Date picker when the stockCageDOBTextField
     * starts to be edited.
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == stockCageDOBTextField {
            let datePickerView:UIDatePicker = UIDatePicker()
            
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            textField.inputView = datePickerView

            datePickerView.addTarget(self, action: #selector(StockCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
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

extension StockCageViewController: QRScannerControllerDelegate {
    func qrScannerController(controller: QRScannerController, didScanQRCodeWith value: String) {
        if wasSetIdScanButtonPressedLast {
            controller.dismiss(animated: true) {
                //Find the cage object
                self.newCageId = value
                self.cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
            }
        }
        else {
            controller.dismiss(animated: true) {
                self.hasDOBListBeenAltered = true
                QueryServer.shared.getBreedingCageBy(id: value, completion: { (breedingCage, error) in
                    QueryServer.shared.getSellingCageBy(id: value, completion: { (sellingCage, error) in
                        if let theBreedingCage = breedingCage {
                            if let theLitterDOB = theBreedingCage.litterDOB {
                                if self.isNewCage {
                                    //Instead of using LitterDOB, add all LitterLogs to RackUtility functionality. Then here, search for motherCageId in litterLogs that matches the current
                                    //cages ID. Once we find matches, store in an array, then sort to find most recent. Then append THAT logs DOB here instead of the cages LitterDOB.
                                    if !(self.stockCageDOBList.contains(theLitterDOB.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))) {
                                        self.stockCageDOBList.append(theLitterDOB.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))
                                    }
                                }
                                else {
                                    if !(self.stockCageNewDOBList.contains(theLitterDOB.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))) {
                                        self.stockCageDOBList.append(theLitterDOB.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))
                                        self.stockCageNewDOBList.append(theLitterDOB.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))
                                    }
                                }
                                
                            }
                        }
                        if let theSellingCage = sellingCage {
                            for cage in theSellingCage.parentCages {
                                if let theCage = self.cage {
                                    for parentCage in theCage.parentCages {
                                        if self.isNewCage {
                                            if !(self.stockCageDOBList.contains((parentCage.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))!)) {
                                                self.stockCageDOBList.append((parentCage.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))!)
                                            }
                                        }
                                        else {
                                            if !(self.stockCageNewDOBList.contains((parentCage.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))!)) {
                                                self.stockCageDOBList.append((parentCage.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))!)
                                                self.stockCageNewDOBList.append((parentCage.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))!)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.stockCageDOBTableView.reloadData()
                        }
                    })
                })
            }
        }
    }
}
