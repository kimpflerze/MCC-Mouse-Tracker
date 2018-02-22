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

class SettingsViewController: UIViewController, UITextFieldDelegate, ValidationDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickOption = [["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
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
    @IBOutlet weak var maleInCageAlertAdvanceTextField: UITextField!
    @IBOutlet weak var pupsInCageAlertAdvanceTextField: UITextField!
    @IBOutlet weak var pupsToWeanAlertAdvanceTextField: UITextField!
    @IBOutlet weak var maleTooOldAlertAdvanceTextField: UITextField!
    @IBOutlet weak var femaleTooOldAlertAdvanceTextField: UITextField!
    @IBOutlet weak var cageWithOrderAlertAdvanceTextField: UITextField!
    
    //Buttons
    @IBOutlet weak var doneButton: UIButton!
    //Button Collections for Alert Colors
    @IBOutlet var maleInCageAlertColorButtonCollection: [UIButton]!
    @IBOutlet var pupsInCageAlertColorButtonCollection: [UIButton]!
    @IBOutlet var pupsToWeanAlertColorButtonCollection: [UIButton]!
    @IBOutlet var maleTooOldAlertColorButtonCollection: [UIButton]!
    @IBOutlet var femaleTooOldAlertColorButtonCollection: [UIButton]!
    @IBOutlet var cageWithOrderAlertColorButtonCollection: [UIButton]!
    
    //Variables to go with the above alert color selections
    var maleInCageAlertColor = ""
    var pupsInCageAlertColor = ""
    var pupsToWeanAlertColor = ""
    var maleTooOldAlertColor = ""
    var femaleTooOldAlertColor = ""
    var cageWithOrderAlertColor = ""
    
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
        
        maleInCageAlertAdvanceTextField.delegate = self
        pupsInCageAlertAdvanceTextField.delegate = self
        pupsToWeanAlertAdvanceTextField.delegate = self
        maleTooOldAlertAdvanceTextField.delegate = self
        femaleTooOldAlertAdvanceTextField.delegate = self
        cageWithOrderAlertAdvanceTextField.delegate = self
        
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
        let maleInCageAlertAdvancePickerView = UIPickerView()
        let pupsInCageAlertAdvancePickerView = UIPickerView()
        let pupsToWeanAlertAdvancePickerView = UIPickerView()
        let maleTooOldAlertAdvancePickerView = UIPickerView()
        let femaleTooOldAlertAdvancePickerView = UIPickerView()
        let cageWithOrderAlertAdvancePickerView = UIPickerView()
        
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
        maleInCageAlertAdvancePickerView.delegate = self
            maleInCageAlertAdvancePickerView.tag = 5
        pupsInCageAlertAdvancePickerView.delegate = self
            pupsInCageAlertAdvancePickerView.tag = 6
        pupsToWeanAlertAdvancePickerView.delegate = self
            pupsToWeanAlertAdvancePickerView.tag = 7
        maleTooOldAlertAdvancePickerView.delegate = self
            maleTooOldAlertAdvancePickerView.tag = 8
        femaleTooOldAlertAdvancePickerView.delegate = self
            femaleTooOldAlertAdvancePickerView.tag = 9
        cageWithOrderAlertAdvancePickerView.delegate = self
            cageWithOrderAlertAdvancePickerView.tag = 10
        
        weaningPeriodTextField.inputView = weaningPickerView
        breedingPeriodTextField.inputView = breedingPickerView
        gestationPeriodTextField.inputView = gestationPickerView
        maleLifeSpanTextField.inputView = maleLifeSpanPickerView
        femaleLifeSpanTextField.inputView = femaleLifeSpanPickerView
        maleInCageAlertAdvanceTextField.inputView = maleInCageAlertAdvancePickerView
        pupsInCageAlertAdvanceTextField.inputView = pupsInCageAlertAdvancePickerView
        pupsToWeanAlertAdvanceTextField.inputView = pupsToWeanAlertAdvancePickerView
        maleTooOldAlertAdvanceTextField.inputView = maleTooOldAlertAdvancePickerView
        femaleTooOldAlertAdvanceTextField.inputView = femaleTooOldAlertAdvancePickerView
        cageWithOrderAlertAdvanceTextField.inputView = cageWithOrderAlertAdvancePickerView
        
        //Toolbar to allow for dismissal of the picker views
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingsViewController.donePicker))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        //Assigning the toolbard created above to all of the textfields that use a pickerview.
        weaningPeriodTextField.inputAccessoryView = toolBar
        breedingPeriodTextField.inputAccessoryView = toolBar
        gestationPeriodTextField.inputAccessoryView = toolBar
        maleLifeSpanTextField.inputAccessoryView = toolBar
        femaleLifeSpanTextField.inputAccessoryView = toolBar
        maleInCageAlertAdvanceTextField.inputAccessoryView = toolBar
        pupsInCageAlertAdvanceTextField.inputAccessoryView = toolBar
        pupsToWeanAlertAdvanceTextField.inputAccessoryView = toolBar
        maleTooOldAlertAdvanceTextField.inputAccessoryView = toolBar
        femaleTooOldAlertAdvanceTextField.inputAccessoryView = toolBar
        cageWithOrderAlertAdvanceTextField.inputAccessoryView = toolBar
        
        //Query for settings just in case there are any changes
        let downloadSettingsHUD = MBProgressHUD.showAdded(to: view, animated: true)
        downloadSettingsHUD.detailsLabel.text = "Checking for settings updates..."
        QueryServer.shared.getSettings {
            downloadSettingsHUD.hide(animated: true)
            DispatchQueue.main.async {
                //Filling the text fields with downloaded information - Complete the rest of these!
                if let theNumRacks = Settings.shared.numRacks {
                    self.numRacksTextField.text = String(theNumRacks)
                }
                if let theNumRows = Settings.shared.numRows {
                    self.numRowsTextField.text = String(theNumRows)
                }
                if let theNumColumns = Settings.shared.numColumns {
                    self.numColumnsTextField.text = String(theNumColumns)
                }
                if let theGestationPeriodNumber = Settings.shared.gestationPeriodNumber, let theGestationPeriodUnit = Settings.shared.gestationPeriodUnit {
                    self.gestationPeriodTextField.text = String(theGestationPeriodNumber) + " " + self.timeUnitNumberToString(timeUnit: theGestationPeriodUnit)
                }
                if let theWeaningPeriodNumber = Settings.shared.weaningPeriodNumber, let theWeaningPeriodUnit = Settings.shared.weaningPeriodUnit {
                    self.weaningPeriodTextField.text = String(theWeaningPeriodNumber) + " " + self.timeUnitNumberToString(timeUnit: theWeaningPeriodUnit)
                }
                if let theBreedingPeriodNumber = Settings.shared.breedingPeriodNumber, let theBreedingPeriodUnit = Settings.shared.breedingPeriodUnit {
                    self.breedingPeriodTextField.text = String(theBreedingPeriodNumber) + " " + self.timeUnitNumberToString(timeUnit: theBreedingPeriodUnit)
                }
                if let theMaleLifespan = Settings.shared.maleLifeSpanNumber, let theMaleLifespanUnit = Settings.shared.maleLifeSpanUnit {
                    self.maleLifeSpanTextField.text = String(theMaleLifespan) + " " + self.timeUnitNumberToString(timeUnit: theMaleLifespanUnit)
                }
                if let theFemaleLifespan = Settings.shared.femaleLifeSpanNumber, let theFemaleLifespanUnit = Settings.shared.femaleLifeSpanUnit {
                    self.femaleLifeSpanTextField.text = String(theFemaleLifespan) + " " + self.timeUnitNumberToString(timeUnit: theFemaleLifespanUnit)
                }
                if let theCostPerMaleMouse = Settings.shared.costPerMaleMouse {
                    self.maleCostTextField.text = "$" + String(theCostPerMaleMouse)
                }
                if let theCostPerFemaleMouse = Settings.shared.costPerFemaleMouse {
                    self.femaleCostTextField.text = "$" + String(theCostPerFemaleMouse)
                }
                if let theCostPerCage = Settings.shared.costPerCagePerDay {
                    self.cageCostTextField.text = "$" + String(theCostPerCage)
                }
                
                //Alert Advance information
                if let theMaleInCageAlertAdvanceNumber = Settings.shared.maleInCageAlertAdvanceNumber, let theMaleInCageAlertAdvanceUnit = Settings.shared.maleInCageAlertAdvanceUnit {
                    self.maleInCageAlertAdvanceTextField.text = String(theMaleInCageAlertAdvanceNumber) + " " + self.timeUnitNumberToString(timeUnit: theMaleInCageAlertAdvanceUnit)
                }
                if let thePupsInCageAlertAdvanceNumber = Settings.shared.pupsInCageAlertAdvanceNumber, let thePupsInCageAlertAdvanceUnit = Settings.shared.pupsInCageAlertAdvanceUnit {
                    self.pupsInCageAlertAdvanceTextField.text = String(thePupsInCageAlertAdvanceNumber) + " " + self.timeUnitNumberToString(timeUnit: thePupsInCageAlertAdvanceUnit)
                }
                if let thePupsToWeanAlertAdvanceNumber = Settings.shared.pupsToWeanAlertAdvanceNumber, let thePupsToWeanAlertAdvanceUnit = Settings.shared.pupsToWeanAlertAdvanceUnit {
                    self.pupsToWeanAlertAdvanceTextField.text = String(thePupsToWeanAlertAdvanceNumber) + " " + self.timeUnitNumberToString(timeUnit: thePupsToWeanAlertAdvanceUnit)
                }
                if let theMaleTooOldAlertAdvanceNumber = Settings.shared.maleTooOldAlertAdvanceNumber, let theMaleTooOldAlertAdvanceUnit = Settings.shared.maleTooOldAlertAdvanceUnit {
                    self.maleTooOldAlertAdvanceTextField.text = String(theMaleTooOldAlertAdvanceNumber) + " " + self.timeUnitNumberToString(timeUnit: theMaleTooOldAlertAdvanceUnit)
                }
                if let theFemaleTooOldAlertAdvanceNumber = Settings.shared.femaleTooOldAlertAdvanceNumber, let theFemaleTooOldAlertAdvanceUnit = Settings.shared.femaleTooOldAlertAdvanceUnit {
                    self.femaleTooOldAlertAdvanceTextField.text = String(theFemaleTooOldAlertAdvanceNumber) + " " + self.timeUnitNumberToString(timeUnit: theFemaleTooOldAlertAdvanceUnit)
                }
                
                self.cageWithOrderAlertAdvanceTextField.text = "This may not even be needed! Discuss with group!"
                
                //Alert color setting on viewDidLoad
                if let theMaleInCageAlertIcon = Settings.shared.maleInCageAlertIcon {
                    for aButton in self.maleInCageAlertColorButtonCollection {
                        if aButton.currentImage == theMaleInCageAlertIcon {
                            self.maleInCageColorSelectionButtonPressed(aButton)
                        }
                    }
                }
                if let thePupsInCageAlertIcon = Settings.shared.pupsInCageAlertIcon {
                    for aButton in self.pupsInCageAlertColorButtonCollection {
                        if aButton.currentImage == thePupsInCageAlertIcon {
                            self.pupsInCageColorSelectionButtonPressed(aButton)
                        }
                    }
                }
                if let thePupsToWeanAlertIcon = Settings.shared.pupsToWeanAlertIcon {
                    for aButton in self.pupsToWeanAlertColorButtonCollection {
                        if aButton.currentImage == thePupsToWeanAlertIcon {
                            self.pupsToWeanColorSelectionButtonPressed(aButton)
                        }
                    }
                }
                if let theMaleTooOldAlertIcon = Settings.shared.maleTooOldAlertIcon {
                    for aButton in self.maleTooOldAlertColorButtonCollection {
                        if aButton.currentImage == theMaleTooOldAlertIcon {
                            self.maleTooOldColorSelectionButtonPressed(aButton)
                        }
                    }
                }
                if let theFemaleTooOldAlertIcon = Settings.shared.femaleTooOldAlertIcon {
                    for aButton in self.femaleTooOldAlertColorButtonCollection {
                        if aButton.currentImage == theFemaleTooOldAlertIcon {
                            self.femaleTooOldColorSelectionButtonPressed(aButton)
                        }
                    }
                }
                if let theCageWithOrderAlertIcon = Settings.shared.cageWithOrderAlertIcon {
                    for aButton in self.cageWithOrderAlertColorButtonCollection {
                        if aButton.currentImage == theCageWithOrderAlertIcon {
                            self.cageWithOrderColorSelectionButtonPressed(aButton)
                        }
                    }
                }
                
                
                
            }
        }
    }
    
    func timeUnitNumberToString(timeUnit : Int) -> String {
        switch timeUnit {
        case 1:
            return "day(s)"
        case 2:
            return "week(s)"
        case 3:
            return "month(s)"
        case 4:
            return "year(s)"
        default:
            print("There was an error converting the unit for this value!")
        }
        return "Error: Bad Unit Value"
    }
    
    func timeUnitStringToNumber(timeUnit : String) -> Int {
        switch timeUnit {
        case "day(s)":
            return 1
        case "week(s)":
            return 2
        case "month(s)":
            return 3
        case "year(s)":
            return 4
        default:
            return 0
        }
        
    }
    
    
    @objc func donePicker() {
        self.view.endEditing(true)
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
        
        print("[TO-DO] Update period information in the SettingsViewController doneButtonPressed Method!")
        if(weaningPeriodTextField.text != nil && weaningPeriodTextField.text != "") {
            guard let theWeaningPeriod = weaningPeriodTextField.text?.components(separatedBy: " ") else {
                print("Failed to split text")
                return
            }
            let theWeaningPeriodNumber = theWeaningPeriod[0]
            let theWeaningPeriodUnit = theWeaningPeriod[1]
            parameters["WeaningPeriod"] = String(theWeaningPeriodNumber)
            parameters["WeaningPeriodUnit"] = String(timeUnitStringToNumber(timeUnit: theWeaningPeriodUnit))
        }
        if(breedingPeriodTextField.text != nil && breedingPeriodTextField.text != "") {
            guard let theBreedingPeriod = breedingPeriodTextField.text?.components(separatedBy: " ") else {
                print("Failed to split text")
                return
            }
            let theBreedingPeriodNumber = theBreedingPeriod[0]
            let theBreedingPeriodUnit = theBreedingPeriod[1]
            parameters["BreedingPeriod"] = String(theBreedingPeriodNumber)
            parameters["BreedingPeriodUnit"] = String(timeUnitStringToNumber(timeUnit: theBreedingPeriodUnit))
        }
        if(gestationPeriodTextField.text != nil && gestationPeriodTextField.text != "") {
            guard let theGestationPeriod = gestationPeriodTextField.text?.components(separatedBy: " ") else {
                print("Failed to split text")
                return
            }
            let theGestationPeriodNumber = theGestationPeriod[0]
            let theGestationPeriodUnit = theGestationPeriod[1]
            parameters["GestationPeriod"] = String(theGestationPeriodNumber)
            parameters["GestationPeriodUnit"] = String(timeUnitStringToNumber(timeUnit: theGestationPeriodUnit))
        }
        if(maleLifeSpanTextField.text != nil && maleLifeSpanTextField.text != "") {
            guard let theMaleLifespan = maleLifeSpanTextField.text?.components(separatedBy: " ") else {
                print("Failed to split text")
                return
            }
            let theMaleLifespanNumber = theMaleLifespan[0]
            let theMaleLifespanUnit = theMaleLifespan[1]
            parameters["MaleLifespan"] = String(theMaleLifespanNumber)
            parameters["MaleLifespanUnit"] = String(timeUnitStringToNumber(timeUnit: theMaleLifespanUnit))
        }
        if(femaleLifeSpanTextField.text != nil && femaleLifeSpanTextField.text != "") {
            guard let theFemaleLifespan = femaleLifeSpanTextField.text?.components(separatedBy: " ") else {
                print("Failed to split text")
                return
            }
            let theFemaleLifespanNumber = theFemaleLifespan[0]
            let theFemaleLifespanUnit = theFemaleLifespan[1]
            parameters["FemaleLifespan"] = String(theFemaleLifespanNumber)
            parameters["FemaleLifespanUnit"] = String(timeUnitStringToNumber(timeUnit: theFemaleLifespanUnit))
        }
        if(pupsToWeanAlertAdvanceTextField.text != nil && pupsToWeanAlertAdvanceTextField.text != "") {
            guard let thePupsToWeanAlertAdvanceInfo = pupsToWeanAlertAdvanceTextField.text?.components(separatedBy: " ") else {
                print("Failed to split text")
                return
            }
            let thePupsToWeanAlertAdvanceNumber = thePupsToWeanAlertAdvanceInfo[0]
            let thePupsToWeanAlertAdvanceUnit = thePupsToWeanAlertAdvanceInfo[1]
            parameters["WeaningAlertAdvance"] = String(thePupsToWeanAlertAdvanceNumber)
            parameters["WeaningAlertAdvanceUnit"] = String(timeUnitStringToNumber(timeUnit: thePupsToWeanAlertAdvanceUnit))
        }
        if(maleTooOldAlertAdvanceTextField.text != nil && maleTooOldAlertAdvanceTextField.text != "") {
            guard let theMaleTooOldAlertAdvanceInfo = maleTooOldAlertAdvanceTextField.text?.components(separatedBy: " ") else {
                print("Failed to split text")
                return
            }
            let theMaleTooOldAlertAdvanceNumber = theMaleTooOldAlertAdvanceInfo[0]
            let theMaleTooOldAlertAdvanceUnit = theMaleTooOldAlertAdvanceInfo[1]
            parameters["OldMaleAlertAdvance"] = String(theMaleTooOldAlertAdvanceNumber)
            parameters["OldMaleAlertAdvanceUnit"] = String(timeUnitStringToNumber(timeUnit: theMaleTooOldAlertAdvanceUnit))
        }
        if(femaleTooOldAlertAdvanceTextField.text != nil && femaleTooOldAlertAdvanceTextField.text != "") {
            guard let theFemaleTooOldAlertAdvanceInfo = femaleTooOldAlertAdvanceTextField.text?.components(separatedBy: " ") else {
                print("Failed to split text")
                return
            }
            let theFemaleTooOldAlertAdvanceNumber = theFemaleTooOldAlertAdvanceInfo[0]
            let theFemaleTooOldAlertAdvanceUnit = theFemaleTooOldAlertAdvanceInfo[1]
            parameters["OldFemaleAlertAdvance"] = String(theFemaleTooOldAlertAdvanceNumber)
            parameters["OldFemaleAlertAdvanceUnit"] = String(timeUnitStringToNumber(timeUnit: theFemaleTooOldAlertAdvanceUnit))
        }
        if(maleInCageAlertAdvanceTextField.text != nil && maleInCageAlertAdvanceTextField.text != "") {
            guard let theMaleInCageAlertAdvanceInfo = maleInCageAlertAdvanceTextField.text?.components(separatedBy: " ") else {
                print("Failed to split text")
                return
            }
            let theMaleInCageAlertAdvanceNumber = theMaleInCageAlertAdvanceInfo[0]
            let theMaleInCageAlertAdvanceUnit = theMaleInCageAlertAdvanceInfo[1]
            parameters["BreedingAlertAdvance"] = String(theMaleInCageAlertAdvanceNumber)
            parameters["BreedingAlertAdvanceUnit"] = String(timeUnitStringToNumber(timeUnit: theMaleInCageAlertAdvanceUnit))
        }
        
        for aButton in maleInCageAlertColorButtonCollection {
            if aButton.alpha != 0.3 {
                if let currentImage = aButton.currentImage {
                    parameters["MaleInCageColor"] = iconImageToColorIndex(icon: currentImage)
                }
            }
        }
        for aButton in pupsInCageAlertColorButtonCollection {
            if aButton.alpha != 0.3 {
                if let currentImage = aButton.currentImage {
                    parameters["PupsInCageColor"] = iconImageToColorIndex(icon: currentImage)
                }
            }
        }
        for aButton in pupsToWeanAlertColorButtonCollection {
            if aButton.alpha != 0.3 {
                if let currentImage = aButton.currentImage {
                    parameters["PupsToWeanColor"] = iconImageToColorIndex(icon: currentImage)
                }
            }
        }
        for aButton in maleTooOldAlertColorButtonCollection {
            if aButton.alpha != 0.3 {
                if let currentImage = aButton.currentImage {
                    parameters["MaleTooOldColor"] = iconImageToColorIndex(icon: currentImage)
                }
            }
        }
        for aButton in femaleTooOldAlertColorButtonCollection {
            if aButton.alpha != 0.3 {
                if let currentImage = aButton.currentImage {
                    parameters["FemaleTooOldColor"] = iconImageToColorIndex(icon: currentImage)
                }
            }
        }
        for aButton in cageWithOrderAlertColorButtonCollection {
            if aButton.alpha != 0.3 {
                if let currentImage = aButton.currentImage {
                    parameters["CageWithOrderColor"] = iconImageToColorIndex(icon: currentImage)
                }
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
    
    func iconImageToColorIndex(icon: UIImage) -> String {
        switch icon {
        case #imageLiteral(resourceName: "RedDot"):
            return "0"
        case #imageLiteral(resourceName: "OrangeDot"):
            return "1"
        case #imageLiteral(resourceName: "YellowDot"):
            return "2"
        case #imageLiteral(resourceName: "GreenDot"):
            return "3"
        case #imageLiteral(resourceName: "CyanDot"):
            return "4"
        case #imageLiteral(resourceName: "BlueDot"):
            return "5"
        case #imageLiteral(resourceName: "PurpleDot"):
            return "6"
        default:
            return "Error! Couldnt convert icon to color index!"
        }
    }
    
    @IBAction func maleInCageColorSelectionButtonPressed(_ sender: UIButton) {
        for aButton in maleInCageAlertColorButtonCollection {
            if aButton.tag != sender.tag {
                aButton.alpha = 0.3
            }
            else {
                aButton.alpha = 1
            }
        }
    }
    
    @IBAction func pupsInCageColorSelectionButtonPressed(_ sender: UIButton) {
        for aButton in pupsInCageAlertColorButtonCollection {
            if aButton.tag != sender.tag {
                aButton.alpha = 0.3
            }
            else {
                aButton.alpha = 1
            }
        }
    }
    
    @IBAction func pupsToWeanColorSelectionButtonPressed(_ sender: UIButton) {
        for aButton in pupsToWeanAlertColorButtonCollection {
            if aButton.tag != sender.tag {
                aButton.alpha = 0.3
            }
            else {
                aButton.alpha = 1
            }
        }
    }
    
    @IBAction func maleTooOldColorSelectionButtonPressed(_ sender: UIButton) {
        for aButton in maleTooOldAlertColorButtonCollection {
            if aButton.tag != sender.tag {
                aButton.alpha = 0.3
            }
            else {
                aButton.alpha = 1
            }
        }
    }
    
    @IBAction func femaleTooOldColorSelectionButtonPressed(_ sender: UIButton) {
        for aButton in femaleTooOldAlertColorButtonCollection {
            if aButton.tag != sender.tag {
                aButton.alpha = 0.3
            }
            else {
                aButton.alpha = 1
            }
        }
    }
    
    @IBAction func cageWithOrderColorSelectionButtonPressed(_ sender: UIButton) {
        for aButton in cageWithOrderAlertColorButtonCollection {
            if aButton.tag != sender.tag {
                aButton.alpha = 0.3
            }
            else {
                aButton.alpha = 1
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
        }
        else if pickerView.tag == 1{
            breedingPeriodTextField.text = count + " " + option
        }
        else if pickerView.tag == 2 {
            gestationPeriodTextField.text = count + " " + option
        }
        else if pickerView.tag == 3 {
            maleLifeSpanTextField.text = count + " " + option
        }
        else if pickerView.tag == 4 {
            femaleLifeSpanTextField.text = count + " " + option
        }
        else if pickerView.tag == 5 {
            maleInCageAlertAdvanceTextField.text = count + " " + option
        }
        else if pickerView.tag == 6 {
            pupsInCageAlertAdvanceTextField.text = count + " " + option
        }
        else if pickerView.tag == 7 {
            pupsToWeanAlertAdvanceTextField.text = count + " " + option
        }
        else if pickerView.tag == 8 {
            maleTooOldAlertAdvanceTextField.text = count + " " + option
        }
        else if pickerView.tag == 9 {
            femaleTooOldAlertAdvanceTextField.text = count + " " + option
        }
        else if pickerView.tag == 10 {
            cageWithOrderAlertAdvanceTextField.text = count + " " + option
        }
        else {
            print("There was an error when setting the text in a textfield that recieves information from a picker view in SettingsViewController.swift!")
        }
//        self.view.endEditing(true)
    }
    /***********************************************************************/
    
    
    
    /************************ TEXTFIELD FUNCTIONS *************************/
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return true
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
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
