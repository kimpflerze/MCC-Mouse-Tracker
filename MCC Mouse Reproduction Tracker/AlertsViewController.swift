//
//  AlertsViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 2/8/18.
//  Copyright © 2018 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD

class AlertsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var alertArray = [Alert]()
    
    //var tempAlertArray = [tempAlert]()
    
    @IBOutlet weak var alertsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let alertOne = tempAlert(title: "Weaning Alert", subtitle: "weam cage 1:1", alertIcon: nil)
//        let alertTwo = tempAlert(title: "Old Male Alert", subtitle: "old male in cage 2:1", alertIcon: nil)
//        let alertThree = tempAlert(title: "Pups Alert", subtitle: "pups sited in cage 2:3", alertIcon: nil)
//        let alertFour = tempAlert(title: "Old Female Alert", subtitle: "old female in cage 2:3", alertIcon: nil)
//        let alertFive = tempAlert(title: "Add Breeding Male Alert", subtitle: "add male to cage cage 1:1", alertIcon: nil)
//
//        tempAlertArray = [alertOne, alertTwo, alertThree, alertFour, alertFive]
        
        // download alerts
        queryAlerts()
        
        
        alertsTableView.delegate = self
        alertsTableView.dataSource = self
        
        //alertsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func queryAlerts() {
        let alertsDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        alertsDownloadHUD.detailsLabel.text = "Downloading alerts ..."
        QueryServer.shared.getAlerts{(downloadedAlerts, error) in
            alertsDownloadHUD.hide(animated: true)
            if let alerts = downloadedAlerts {
                self.alertArray = alerts
                DispatchQueue.main.async {
                    print("You have queried \(self.alertArray.count) alerts")
                    print("alert Array \(self.alertArray)")
                    print(self.alertArray[0].alertTypeDescription)
                    print(self.alertArray[0].alertTypeID)
                    print(self.alertArray[0].subjectId)
                    print(self.alertArray[1].alertTypeDescription)
                    print(self.alertArray[1].alertTypeID)
                    print(self.alertArray[1].subjectId)
                }
                
            }
        }
    }
    /*TODO: create a refresh button to query alerts and update table*/
    /*
     * Updates Alerts View to reflect current alerts table
     */
    func updateView(){
        queryAlerts()
        alertsTableView.reloadData()
    }
    
    
    /*func updateAlerts(){
        // update DB and alert array in case alerts are removed.
        // alert should also be unassociated from any cage.
    }*/
    
    
    /* TableView Delegate Functions */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.alertArray.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell")
        
        cell.textLabel?.text = self.alertArray[indexPath.row].alertTypeDescription
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.alertArray.remove(at: indexPath.row)
            alertsTableView.reloadData()}
    }
 
    override func viewDidAppear(_ animated: Bool) {
        alertsTableView.reloadData()
    }
   
}

/*
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
*/
