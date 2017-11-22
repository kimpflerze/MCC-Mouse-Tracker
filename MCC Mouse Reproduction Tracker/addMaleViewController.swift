//
//  addMaleViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD

class addMaleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        //Depending on if isNewCage is true or false, will either update or insert into the database
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
            if(!hasInformationChanged()) {
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
        
//        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressed_addParentCageIDButton(_ sender: UIButton) {
        print("pressed add parent cage ID button")
        
        if(parentCageIDTextField.text != "")
        {
            parentCageIDList.append(parentCageIDTextField.text!)
            print("     We added a parent cage ID!")
            parentCageIDTableView.reloadData()
        }
    }
    
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

  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
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
