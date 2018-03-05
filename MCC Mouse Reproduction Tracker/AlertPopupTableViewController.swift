//
//  AlertPopupTableViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 2/24/18.
//  Copyright © 2018 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD

class AlertPopupTableViewController: UITableViewController {

     var cageAlertArray = [Alert]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cageAlertArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...

        return cell
    }
  
    func queryAlerts() {
        let alertsDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        alertsDownloadHUD.detailsLabel.text = "Downloading alerts ..."
        print("downloading alerts ...")
        QueryServer.shared.getAlerts{(downloadedAlerts, error) in
            alertsDownloadHUD.hide(animated: true)
            if let alerts = downloadedAlerts {
                self.cageAlertArray = alerts
                DispatchQueue.main.async {
                    print("You have queried \(self.cageAlertArray.count) alerts")
                }
            } else {
                print("There are no alerts at this time.")
            }
        }
    }

    /* Unable to remove alerts from the tableView*/
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }


    
    // MARK: - Navigation
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

