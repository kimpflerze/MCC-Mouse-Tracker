//
//  CageAlertsViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 2/24/18.
//  Copyright © 2018 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD

class CageAlertsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    /* Variables */
    
    var cageAlertArray = [Alert]()
    @IBOutlet weak var cageAlertsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cageAlertsTableView.delegate = self
        cageAlertsTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    /* TableView Delegate Functions */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.cageAlertArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell")
        cell.textLabel?.text = self.cageAlertArray[indexPath.row].alertTypeDescription
        return cell
    }
    
    /* Unable to remove alerts from the tableView*/
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    override func viewDidAppear(_ animated: Bool) {
        cageAlertsTableView.reloadData()
    }
    
    /**
     * Dismisses this view.
    */
    @IBAction func dismissPopover(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}




