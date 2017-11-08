//
//  addMaleViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class addMaleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var parentCageIDList = [String]()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        parentCageIDTableView.dataSource = self
        parentCageIDTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        print("pressed QR Code button")
    }
    
    @IBAction func pressed_done_btn(_ sender: UIButton) {
        print("pressed done button")
        /* save information database */
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
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(breedingCageViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        maleDOBTextField.text = dateFormatter.string(from: sender.date)
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
