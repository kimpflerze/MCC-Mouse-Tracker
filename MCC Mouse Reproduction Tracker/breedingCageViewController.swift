//
//  breedingCageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 11/4/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class breedingCageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var parentDOBList = [String]()
    var parentCageList = [String]()
    
    // Buttons
    @IBOutlet weak var add_litter_btn: UIButton!
    
    @IBOutlet weak var QR_code_btn: UIButton!
    
    @IBOutlet weak var add_male_btn: UIButton!

    @IBOutlet weak var done_btn: UIButton!
    
    @IBOutlet weak var addParentDOBButton: UIButton!
    
    @IBOutlet weak var addParentCageButton: UIButton!
    
    
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
        
        // Do any additional setup after loading the view.
        parentDOBTableView.dataSource = self
        parentDOBTableView.delegate = self
        
        
        parentCageTableView.dataSource = self
        parentCageTableView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
    @IBAction func pressed_QR_Code_btn(_ sender: UIButton) {
        print("pressed QR Code button")
    }
    
    @IBAction func pressed_add_litter_btn(_ sender: UIButton) {
        print("pressed Add litter button")
    }
    
    @IBAction func pressed_add_male_btn(_ sender: UIButton) {
        print("pressed Add Male button")
    }
    
    @IBAction func pressed_done_btn(_ sender: UIButton) {
        print("pressed done button")
        /* save information database */
    }
   
    @IBAction func pressed_addParentDOBButton(_ sender: UIButton) {
        print("pressed add parent DOB button")
        
        if(parentDOBTextField.text != "")
        {
           parentDOBList.append(parentDOBTextField.text!)
            print("     We added a parent DOB")
            parentDOBTableView.reloadData()
        }
    }
    
    @IBAction func pressed_addParentCageButton(_ sender: UIButton) {
        print("pressed add parent cage button")
        
        if(parentCageTextField.text != "")
        {
            parentCageList.append(parentCageTextField.text!)
            print("     We added a parent cage")
            parentCageTableView.reloadData()
        }
    }
    
    @IBAction func addParentDOBEditing(_ sender: UITextField) {
        
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
    
        parentDOBTextField.text = dateFormatter.string(from: sender.date)        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
