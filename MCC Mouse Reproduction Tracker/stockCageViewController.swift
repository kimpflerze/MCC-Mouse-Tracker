//
//  stockCageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD

class stockCageViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource  {
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
        
        stockCageParentCageIdList.append("ORIGIN")
        
        stockCageDOBTableView.dataSource = self
        stockCageDOBTableView.delegate = self
        
        view.bringSubview(toFront: stockCageViewTitleLabel)
        
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
                    if let dateAsString = parentCage.dob?.toString(withFormat: "yyyy-MM-dd HH:mm:s") {
                        if(!stockCageDOBList.contains(dateAsString)) {
                            stockCageDOBList.append(dateAsString)
                            stockCageDOBTableView.reloadData()
                        }
                    }
                }
            }
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
            if (!hasInformationChanged()) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
