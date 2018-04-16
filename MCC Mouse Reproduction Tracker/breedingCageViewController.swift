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
    var originalCageActiveState: Bool?
    
    var delegate: DetailViewControllerDelegate?
    
    //Images
    @IBOutlet weak var cageHasId: UIImageView!
    
    // Buttons
    @IBOutlet weak var add_litter_btn: UIButton!
    @IBOutlet weak var QR_code_btn: UIButton!
    @IBOutlet weak var add_male_btn: UIButton!
    @IBOutlet weak var done_btn: UIButton!
    @IBOutlet weak var scanParentInformationButton: UIButton!

    // TextFields
    @IBOutlet weak var rackNoTextField: UITextField!
    @IBOutlet weak var columnNoTextField: UITextField!
    @IBOutlet weak var rowNoTextField: UITextField!
    @IBOutlet weak var parentDOBTextField: UITextField!
    @IBOutlet weak var parentCageTextField: UITextField!
    
    //Switches
    @IBOutlet weak var cageActiveSwitch: UISwitch!
    
    //TableViews
    @IBOutlet weak var parentDOBTableView: UITableView!
    @IBOutlet weak var parentCageTableView: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // Set TableView and Textfield Delegates
        parentDOBTableView.dataSource = self
        parentDOBTableView.delegate = self
        
        parentCageTableView.dataSource = self
        parentCageTableView.delegate = self
        
        parentDOBTextField.delegate = self
        parentCageTextField.delegate = self
        
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
        parentDOBTextField.inputAccessoryView = toolBar
        parentCageTextField.inputAccessoryView = toolBar
        
        //Register textfields for validation
//        validator.registerField(parentDOBTextField, rules: [RequiredRule(),ValidDateRule()])
//        validator.registerField(parentCageTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rackNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(rowNoTextField, rules: [RequiredRule(), NumericRule()])
        validator.registerField(columnNoTextField, rules: [RequiredRule(), NumericRule()])
        
        //Populate information from passed cage here!
        
        //Filling information for an existing cage
        if let theCage = cage {
            rackNoTextField.text = String(theCage.rack)
            columnNoTextField.text = String(theCage.column)
            rowNoTextField.text = String(theCage.row)
            
            if(isNewCage == false) {
                
                //Setting icon for indication of if cage has an ID set. Only relevant if its a new cage.
                if(theCage.id != "") {
                    cageHasId.image = #imageLiteral(resourceName: "CheckIcon")
                }
                else {
                    cageHasId.image = #imageLiteral(resourceName: "XIcon")
                }
                
                //Setting the "active" switch to "off" if the cage is not an activly used cage.
                originalCageActiveState = theCage.isActive
                if(theCage.isActive == false) {
                    cageActiveSwitch.setOn(false, animated: false)
                }
                
                //Filling parent cage DOB information
                for parentCage in theCage.parentCages {
                    if let dateAsString = parentCage.dob?.toString() {
                        if(parentDOBList.contains(dateAsString) == false) {
                            parentDOBList.append(dateAsString)
                            parentDOBTableView.reloadData()
                        }}}
                //Filling parent cage ID information
                for parentCage in theCage.parentCages {
                    if(!parentCageList.contains(parentCage.parentCageId)) {
                        parentCageList.append(parentCage.parentCageId)
                        parentCageTableView.reloadData()
                    }}}
            else {
                cageHasId.image = #imageLiteral(resourceName: "XIcon")
            }}
        
        //Quick query to determine if male is in cage for purpose of add_male_btn title clarity!
        QueryServer.shared.getBreedingMaleBy(cageId: (cage?.id)!, completion: { (downloadedMale, error) in
            DispatchQueue.main.async {
                if(downloadedMale != nil) {
                    self.add_male_btn.setTitle("View Male", for: .normal)
                }
                else {
                    self.add_male_btn.setTitle("Add Male", for: .normal)
                }
            }})
        
        // Check if there is a litter in the cage or not.
        if (self.cage?.litterInCage)! {
            // litter exists already; only option is to wean it
            self.add_litter_btn.setTitle("Wean Litter", for: .normal)
        }else {
            // litter does not exist so we can add one.
            self.add_litter_btn.setTitle("Add Litter", for: .normal)
        }
        //print("TODO: fix issue with add/wean litter; something to do with the litter id associated with the cage.")
    } // end viewDidLoad()
    
    @objc func donePicker() {
        self.view.endEditing(true)
        
        //Check to see if parentDOB/parentCageID textfields are empty
        if let newParentDOB = parentDOBTextField.text {
            if newParentDOB != "" {
                parentDOBTextField.text = ""
                parentDOBList.append(newParentDOB)
                parentDOBTableView.reloadData()
            }
        }
        
        if let newParentCageID = parentCageTextField.text {
            if newParentCageID != "" {
                parentCageTextField.text = ""
                parentCageList.append(newParentCageID)
                parentCageTableView.reloadData()
            }
        }
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
        //print("textField validation successful!!")
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
        //print("textField validation failed!!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        didSelectScanParentInformationButton = false
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        if let qrVC = mainStoryboard.instantiateViewController(withIdentifier: "scanner") as? QRScannerController {
            qrVC.delegate = self
            present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func pressed_add_litter_btn(_ sender: UIButton) {
        if (self.cage?.litterInCage)! {
            // litter exists in cage so we must wean the litter
            print("Have a litter; must wean it.")
            var cageLitters = [LitterLog]()
            //get all cages and filter by mother.id and father.id
            QueryServer.shared.getAllLitterLogs { (litterLogList, error) in
                DispatchQueue.main.async {
                    if !((litterLogList?.isEmpty)!) {
                        for litter in (litterLogList)! {
                            if litter.fatherId == self.breedingMale?.id && litter.motherCageId == self.cage?.id {
                                cageLitters.append(litter)
                                print("added litter \(litter.id)")
                            }}
                    }else {
                        print("Error finding litter in breedingCage:\(String(describing: self.cage?.id))")
                    }
            }}
            
           // get litter with dob closest to current date
            //(sort it from closest to least closest)!!!
            print("cage has \(cageLitters.count) litters")
            if cageLitters.count > 1 {
            cageLitters.sorted(by: {($0.dob?.timeIntervalSince1970)! < ($1.dob?.timeIntervalSince1970)!})
            }
            
            QueryServer.shared.getLitterLogBy(id: cageLitters[0].id, completion: { (litterLog, error) in
                DispatchQueue.main.async {
                    print("Litter weaned:")
                    if litterLog != nil {
                        litterLog?.dob = nil
                        self.cage?.litterInCage = false
                        self.add_litter_btn.titleLabel?.text = "Add Litter"
                        print(" true")
                    }else {
                        print(" false")
                        print("Error weaning litter in breedingCage:\(String(describing: self.cage?.id))")
                    }
                }
            })
            
            /*
             // Helpful code
                 self.breedingCages = self.breedingCages.map({ (cage) -> Cage in
                 let newCage = cage
                 newCage.maleInCage = theMales.contains(where: { (male) -> Bool in
                 cage.maleInCage = true
                 return male.currentCageId == cage.id
                 })
                 return newCage
             })
             */
            
        } else {
            // No litter exists in cage so we must add a litter
            print("No litter; must add one.")
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
            self.cage?.litterDOB = Date()
            self.cage?.numLittersFromCage += 1
            QueryServer.shared.createLitterLogEntry(motherCageId: cage?.id, completion: { (success) in
                DispatchQueue.main.async {
                    print("Litter created:")
                    if (success != nil) {
                    self.cage?.litterInCage = true
                    self.add_litter_btn.titleLabel?.text = "Wean Litter"
                    print(" true")
                    } else {
                        print(" false")
                    }
                }})
        }
    }
    
    @IBAction func pressed_add_male_btn(_ sender: UIButton) {
        if let addMaleVC = self.storyboard?.instantiateViewController(withIdentifier: "BreedingMale") as? addMaleViewController {
            
            QueryServer.shared.getBreedingMaleBy(cageId: (cage?.id)!, completion: { (downloadedMale, error) in
                DispatchQueue.main.async {
                    if(downloadedMale == nil) {
                        //print("Is new male!")
                        addMaleVC.isNewMale = true
                        addMaleVC.breedingMaleCurrentCage = self.cage
                        addMaleVC.delegate = self.delegate
                        self.present(addMaleVC, animated: true, completion: nil)
                    }
                    else {
                        //print("Is not new male!")
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
        if originalCageActiveState != self.cage?.isActive || rackNoTextField.text != String(theCage.rack) || columnNoTextField.text != String(theCage.column) || rowNoTextField.text != String(theCage.row) {
            //print("Something didnt match!")
            return true
        }
        return hasTableViewChanged
    }
    
    @IBAction func pressed_done_btn(_ sender: UIButton) {

        validator.validate(self)
        
        print("=====Breeding Cage Creation/Update Information=====")
        print("wasValidationSuccessful: \(wasValidationSuccessful)")
        print("isNewCage: \(isNewCage)")

        if(wasValidationSuccessful) {
        //Depending on if isNewCage is true or false, will either update or insert into the database
        if(isNewCage) {
            print("     *New breeding cage is being created!*")
            //New cage, insert into database
            let doneButtonHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            doneButtonHUD.detailsLabel.text = "Sending information..."
            QueryServer.shared.createNewBreedingCage(id: newCageId, row: Int(rowNoTextField.text!), column: Int(columnNoTextField.text!), rack: Int(rackNoTextField.text!), isActive: 1, parentsCagesDOB: parentDOBList, parentCagesId: parentCageList, completion: { (error) in
                debugPrint(error)
                doneButtonHUD.hide(animated: true)
                self.delegate?.detailViewControllerDidSave(controller: self)
            })
        }
        else {
            print("     *Existing breeding cage is being updated!*")
            //Existing cage, update its information

            if (!hasInformationChanged() /*|| !(wasValidationSuccessful)*/) {
                print("         *No information has changed, dismissing view!*")
                dismiss(animated: true, completion: nil)
            }
            else {
                print("         *Information has changed, proceeding with updating!*")
                //print("In else statement, information has changed in BreedingCageViewController!")
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
                    QueryServer.shared.updateBreedingCageWith(id: self.cage?.id, row: self.rowNoTextField.text, column: self.columnNoTextField.text, rack: self.rackNoTextField.text, isActive: numericalStringCageIsActive, completion: { (response) in
                        updateHUD.hide(animated: true)
                        let updateAlert = UIAlertController(title: "Update Cage", message: "The cage information was successfully udpated!", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (response) in
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
    } // end if validation was successful check
    }//end pressed_done_btn() function
  
    
    @IBAction func addParentDOBEditing(_ sender: UITextField) {
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
    
    @IBAction func cageIsActiveSwitchFlipped(_ sender: UISwitch) {
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
                //print("textField validation successful!!")
            } else {
                // Validation error occurred
                print(error?.errorMessage ?? textField.text! + "is an invalid entry")
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            }
        }
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        parentDOBTextField.text = sender.date.toString()
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
        
        QueryServer.shared.getBreedingMaleBy(cageId: (cage?.id)!, completion: { (downloadedMale, error) in
            DispatchQueue.main.async {
                if(downloadedMale != nil) {
                    self.add_male_btn.setTitle("View Male", for: .normal)
                }
                else {
                    self.add_male_btn.setTitle("Add Male", for: .normal)
                }
            }
        })
        
        //Make sure that this "Litter in Cage" Variable is being updated on each press of the add litter button!
        if (self.cage?.litterInCage)! {
            // litter exists already; only option is to wean it
            self.add_litter_btn.setTitle("Wean Litter", for: .normal)
        }else {
            // litter does not exist so we can add one.
            self.add_litter_btn.setTitle("Add Litter", for: .normal)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? CageAlertsViewController {
            destinationVC.cageAlertArray = (cage?.alerts)!
        }
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
        //print("ID Recieved from Scanner! Id: \(value)")
        controller.dismiss(animated: true) {
            //Find the cage object
            if(self.didSelectScanParentInformationButton) {
                let downloadParentCageHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                downloadParentCageHUD.detailsLabel.text = "Downloading parent cage's information..."
                QueryServer.shared.getBreedingCageBy(id: value, completion: { (cage, error) in
                    downloadParentCageHUD.hide(animated: true)
                    if let theDownloadedCage = cage {
                        self.parentCageList.append(theDownloadedCage.id)
                        //Store the actual parent's DOBs! This is done for inbreeding check!
                        for parent in theDownloadedCage.parentCages {
                            self.parentDOBList.append((parent.dob?.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))!)
                        }
                        DispatchQueue.main.async {
                            self.parentCageTableView.reloadData()
                            self.parentDOBTableView.reloadData()
                        }
                    }
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
