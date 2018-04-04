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
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var alertsTableView: UITableView!
    var alertArray = [Alert]()

    let dateFormatter = DateFormatter()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        alertsTableView.delegate = self
        alertsTableView.dataSource = self
        
        updateView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func queryAlerts() {
        let alertsDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        alertsDownloadHUD.detailsLabel.text = "Downloading alerts ..."
       // print("downloading alerts ...")
        QueryServer.shared.getAlerts{(downloadedAlerts, error) in
            alertsDownloadHUD.hide(animated: true)
            if let alerts = downloadedAlerts {
                self.alertArray = alerts
                DispatchQueue.main.async {
                   // print("You have queried \(self.alertArray.count) alerts")
                }
            } else {
               // print("There are no alerts at this time.")
            }
        }
    }
    
    /*
     * Updates Alerts View to reflect current alerts table
     */
    func updateView(){
        queryAlerts()
        alertsTableView.reloadData()
        //print("updated View")
    }

    
    /* TableView Delegate Functions */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.alertArray.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell")
        let alert = self.alertArray[indexPath.row]
        if let date = alert.alertDate {
             cell.textLabel?.text = "\t \(alert.subjectId): \(alert.alertTypeDescription) \t Date:\(dateFormatter.string(from: date))"
        }else{
            cell.textLabel?.text = "\t \(alert.subjectId): \(alert.alertTypeDescription) \t Date: N/A"
        }
        return cell
    }
    
    
    /* Unable to remove alerts from the tableView*/
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
   
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        updateView()
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}

