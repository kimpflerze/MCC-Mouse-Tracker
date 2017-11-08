//
//  stockCageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class stockCageViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource  {


    var stockCageDOBList = [String]()
    var genderFlag = 0
    
    
    //TextLabel
    
    @IBOutlet weak var genderFlagTextLabel: UILabel!
    
    
    //TextFields
    @IBOutlet weak var rackNoTextField: UITextField!
    @IBOutlet weak var columnNoTextField: UITextField!
    @IBOutlet weak var rowNoTextField: UITextField!
    @IBOutlet weak var miceCountTextField: UITextField!
    @IBOutlet weak var stockCageDOBTextField: UITextField!
    
    //Switches
    @IBOutlet weak var genderFlagSwitch: UISwitch!
    
    //Buttons
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addDOBButton: UIButton!
    @IBOutlet weak var QRCodeButton: UIButton!
    
    //TableViews
    @IBOutlet weak var stockCageDOBTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         stockCageDOBTableView.dataSource = self
         stockCageDOBTableView.delegate = self
        
        genderFlagSwitch.isOn = false
        genderFlagTextLabel.text = "Male"
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func genderFlagSwitchedFlipped(_ sender: UISwitch) {
        
        if (genderFlagSwitch.isOn) {
            genderFlag = 1  // female cage
            genderFlagTextLabel.text = "Female"
            print("gender flag set to: female")
        } else {
            genderFlag = 0  // male cage
            genderFlagTextLabel.text = "Male"
            print("gender flag set to: male")
        }
    }
    
    
    
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        print("pressed QR Code button")
    }
    
    @IBAction func pressed_done_btn(_ sender: UIButton) {
        print("pressed done button")
        /* save information database */
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
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
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
