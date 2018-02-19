//
//  AlertsViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 2/8/18.
//  Copyright © 2018 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class AlertsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //array to hold alerts
    // query for alerts on load (maybe for the first 10)
        //when user scrolls down show 10 more alerts
    
    // filter for alert types
    
    // if alert is deleted from view delete it from database
        // also check alert array for deletion as well
    
    // Table Cell should show Alert title, subtitle and alert icon
    
    //var alertArray = [Alert]()
    
    // make specific tableview cell to use for this view.
    
    var tempAlertArray = [tempAlert]()
    
    @IBOutlet weak var alertsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alertOne = tempAlert(title: "Weaning Alert", subtitle: "weam cage 1:1", alertIcon: nil)
        let alertTwo = tempAlert(title: "Old Male Alert", subtitle: "old male in cage 2:1", alertIcon: nil)
        let alertThree = tempAlert(title: "Pups Alert", subtitle: "pups sited in cage 2:3", alertIcon: nil)
        let alertFour = tempAlert(title: "Old Female Alert", subtitle: "old female in cage 2:3", alertIcon: nil)
        let alertFive = tempAlert(title: "Add Breeding Male Alert", subtitle: "add male to cage cage 1:1", alertIcon: nil)
        
        tempAlertArray = [alertOne, alertTwo, alertThree, alertFour, alertFive]
        alertsTableView.delegate = self
        alertsTableView.dataSource = self
        
        // load in alerts
        // queryAlerts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func queryAlerts() {
        // query first 10 alerts
        // add alerts to array
        // display on view
    }
    
    func removeAlert() {
        
    }
    
    func createAlert() {
        
    }
    
    func updateView(){
        // update the table view
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tempAlertArray.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell")
        cell.textLabel?.text = tempAlertArray[indexPath.row].title
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            tempAlertArray.remove(at: indexPath.row)
            alertsTableView.reloadData()}
    }
 
   
}

class tempAlert {
    var title: String
    var subtitle: String
    var alertIcon : UIImage?
    
    init(title: String, subtitle: String, alertIcon: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        if let image = alertIcon {
            self.alertIcon = image
        }else{
            self.alertIcon = nil
        }
    }
}
