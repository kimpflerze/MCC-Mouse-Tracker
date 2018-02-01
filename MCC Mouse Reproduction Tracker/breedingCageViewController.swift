//
//  breedingCageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftValidator

class breedingCageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ValidationDelegate {
    var wasValidationSuccessful = false
    
    // Validator Variable
    let validator = Validator()
    
    //Data sources for Table Views
    var parentDOBList = [String]()
    var parentCageList = [String]()
    
    //Variables for the current view to operate
    var cage: Cage?
    var breedingMale: BreedingMale?
    var isNewCage = false
    var hasTableViewChanged = false
    var newCageId: String?
    var didSelectScanParentInformationButton = false
    
    var delegate: DetailViewControllerDelegate?
    
    //Images
    @IBOutlet weak var cageHasId: UIImageView!
    
    // Buttons
    @IBOutlet weak var add_litter_btn: UIButton!
    @IBOutlet weak var QR_code_btn: UIButton!
    @IBOutlet weak var add_male_btn: UIButton!
    @IBOutlet weak var done_btn: UIButton!
    @IBOutlet weak var addParentDOBButton: UIButton!
    @IBOutlet weak var addParentCageButton: UIButton!
    @IBOutlet weak var scanParentInformationButton: UIButton!
    
    
    
    // TextFields
    @IBOutlet weak var rackNoTextField: UITextField!
    @IBOutlet weak var columnNoTextField: UITextField!
    @IBOutlet weak var rowNoTextField: UITextField!
    @IBOutlet weak var parentDOBTextField: UITextField!
    @IBOutlet weak var parentCageTextField: UITextField!
    
    
    //TableViews
    @IBOutlet weak var parentDOBTableView: UITableView!
    @IBOutlet weak var parentCageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentDOBTableView.dataSource = self
        parentDOBTableView.delegate = self
        
        parentCageTableView.dataSource = self
        parentCageTableView.delegate = self
        
        parentDOBTextField.delegate = self
        parentCageTextField.delegate = self
        
        //Register textfields for validation
        validator.registerField(parentDOBTextField, rules: [RequiredRule(),ValidDateRule()])
        validator.registerField(parentCageTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rackNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rowNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(columnNoTextField, rules: [RequiredRule(), NumericRule()])
        
        //Populate information from passed cage here!
        
        //Filling informatin for an existing cage
        if let theCage = cage {
            rackNoTextField.text = String(theCage.rack)
            columnNoTextField.text = String(theCage.column)
            rowNoTextField.text = String(theCage.row)
            
            if(isNewCage == false) {
                
                if(theCage.id != "") {
                    cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
                }
                else {
                    print("[TO-DO] Correct XIcon not showing in breedingCageViewController.swift")
                    cageHasId.image = #imageLiteral(resourceName: "XIcon")
                }
                
                for parentCage in theCage.parentCages {
//                    if let dateAsString = parentCage.dob?.toString(withFormat: "yyyy-MM-dd HH:mm:s") {
                    if let dateAsString = parentCage.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:s a") {
                        if(!parentDOBList.contains(dateAsString)) {
                            parentDOBList.append(dateAsString)
                            parentDOBTableView.reloadData()
                        }
                    }
                }
                
                for parentCage in theCage.parentCages {
                    if(!parentCageList.contains(parentCage.parentCageId)) {
                        parentCageList.append(parentCage.parentCageId)
                        parentCageTableView.reloadData()
                    }
                }
            }
        }
        
        //Quick query to determine if male is in cage for purpose of add_male_btn title clarity!
        QueryServer.shared.getBreedingMaleBy(cageId: (cage?.id)!, completion: { (downloadedMale, error) in
            DispatchQueue.main.async {
                if(downloadedMale != nil) {
                    self.add_male_btn.setTitle("View Male", for: .normal)
                }
            }
        })
        
    }
    
    func validationSuccessful() {
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner") as? QRScannerController {
            qrVC.delegate = self
            present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressed_add_litter_btn(_ sender: UIButton) {
        
    }
    
    @IBAction func pressed_add_male_btn(_ sender: UIButton) {
        if let addMaleVC = self.storyboard?.instantiateViewController(withIdentifier: "BreedingMale") as? addMaleViewController {
            
            QueryServer.shared.getBreedingMaleBy(cageId: (cage?.id)!, completion: { (downloadedMale, error) in
                DispatchQueue.main.async {
                    if(downloadedMale == nil) {
                        print("Is new male!")
                        addMaleVC.isNewMale = true
                        addMaleVC.breedingMaleCurrentCage = self.cage
                        addMaleVC.delegate = self.delegate
                        self.present(addMaleVC, animated: true, completion: nil)
                    }
                    else {
                        print("Is not new male!")
                        addMaleVC.isNewMale = false
                        addMaleVC.breedingMale = downloadedMale
                        addMaleVC.breedingMaleCurrentCage = self.cage
                        addMaleVC.delegate = self.delegate
                        self.present(addMaleVC, animated: true, completion: nil)
                    }
                }
            })
            
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
    
    @IBAction func pressed_done_btn(_ sender: UIButton) {
        print("[TO-DO] Complete pushing new information to database in breedingCageViewController.swift")
        print("[TO_DO] Complete idiot proofing for done button in breedingCageViewController.swift")
        
        validator.validate(self)
        
        //Depending on if isNewCage is true or false, will either update or insert into the database
        if(isNewCage) {
            //New cage, insert into database
            let doneButtonHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            doneButtonHUD.detailsLabel.text = "Sending information..."
            QueryServer.shared.createNewBreedingCage(id: newCageId, row: Int(rowNoTextField.text!), column: Int(columnNoTextField.text!), rack: Int(rackNoTextField.text!), isActive: 1, parentsCagesDOB: parentDOBList, parentCagesId: parentCageList, completion: { (error) in
                debugPrint(error ?? "There was an error!")
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
                    QueryServer.shared.updateBreedingCageWith(id: self.cage?.id, row: self.rowNoTextField.text, column: self.columnNoTextField.text, rack: self.rackNoTextField.text, isActive: nil, completion: { (response) in
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
            
            //Temporary dismiss! Will be removed once updating is implemented
            
            
        }
        
        
    }
    
    @IBAction func pressed_addParentDOBButton(_ sender: UIButton) {
        if(parentDOBTextField.text != "")
        {
            hasTableViewChanged = true
            parentDOBList.append(parentDOBTextField.text!)
            parentDOBTableView.reloadData()
        }
    }
    
    @IBAction func pressed_addParentCageButton(_ sender: UIButton) {
        if(parentCageTextField.text != "")
        {
            hasTableViewChanged = true
            parentCageList.append(parentCageTextField.text!)
            parentCageTableView.reloadData()
        }
    }
    
    @IBAction func addParentDOBEditing(_ sender: UITextField) {
        
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(breedingCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func scanParentInformationButtonPressed(_ sender: UIButton) {
        didSelectScanParentInformationButton = true
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner") as? QRScannerController {
            qrVC.delegate = self
            present(qrVC, animated: true, completion: nil)
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
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return true
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validator.validateField(textField){ error in
            if error == nil {
                // Field validation was successful
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
                print("textField validation successful!!")
            } else {
                // Validation error occurred
                print(error?.errorMessage ?? textField.text! + "is an invalid entry")
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            }
        }
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        //        let dateFormatter = DateFormatter()
        //
        //        dateFormatter.dateStyle = DateFormatter.Style.short
        //
        //        dateFormatter.timeStyle = DateFormatter.Style.none
        parentDOBTextField.text = sender.date.toString()
        /* https://blog.apoorvmote.com/change-textfield-input-to-datepicker/ */
    }
    
    
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        parentDOBTableView.reloadData()
        parentCageTableView.reloadData()
    }
    
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
    
}

extension breedingCageViewController: QRScannerControllerDelegate {
    func qrScannerController(controller: QRScannerController, didScanQRCodeWith value: String) {
        print("ID Recieved from Scanner! Id: \(value)")
        controller.dismiss(animated: true) {
            //Find the cage object
            if(self.didSelectScanParentInformationButton) {
                let downloadParentCageHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                downloadParentCageHUD.detailsLabel.text = "Downloading parent cage's information..."
                QueryServer.shared.getBreedingCageBy(id: value, completion: { (cage, error) in
                    downloadParentCageHUD.hide(animated: true)
                    
                    print("[TO-DO] Complete add parent info scanning in BreedingCageViewController.swift")
                    //                    parentDOBList.append(cage?.parentCages.)
                    //                    for parent in cage?.parentCages {
                    //                        parentCageList.append(parent)
                    //                    }
                    //
                    //                    parentCageList.append(contentsOf: cage?.parentCages)
                })
            }
            else {
                self.newCageId = value
                self.cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
            }
        }
    }
}

protocol DetailViewControllerDelegate {
    func detailViewControllerDidSave(controller: UIViewController)
}
