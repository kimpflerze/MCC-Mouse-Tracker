//
//  AlertsViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 2/8/18.
//  Copyright © 2018 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD

class AlertsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var alertsTableView: UITableView!
    var alertArray = [Alert]()
    var breedingCages = [Cage]()
    var sellingCages = [Cage]()
    var breedingMales = [BreedingMale]()

    let dateFormatter = DateFormatter()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
        alertsTableView.delegate = self
        alertsTableView.dataSource = self
        
        updateView()
    }
    
    func findMalesCurrentCage(malesCurrentCageID: String) -> Cage {
        var malesCurrentCage: Cage?
        for cage in breedingCages {
            if cage.id == malesCurrentCageID {
                malesCurrentCage = cage
            }
        }
        for cage in sellingCages {
            if cage.id == malesCurrentCageID {
                malesCurrentCage = cage
            }
        }
        return malesCurrentCage!
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
                   self.queryForMice()
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
    
    func queryForMice(){
        QueryServer.shared.getAllActiveBreedingCages { (breedingCages, breedingCagesError) in
            QueryServer.shared.getAllActiveSellingCages(completion: { (sellingCages, sellingCagesError) in
                QueryServer.shared.getAllActiveBreedingMales(completion: { (breedingMales, breedingMalesError) in
                    DispatchQueue.main.async {
                        if let downloadedBreedingCages = breedingCages {
                            self.breedingCages = downloadedBreedingCages
                        }
                        if let downloadedSellingCages = sellingCages {
                            self.sellingCages = downloadedSellingCages
                        }
                        if let downloadedBreedingMales = breedingMales {
                            self.breedingMales = downloadedBreedingMales
                        }
                    }
                })
            })
        }
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
            cell.textLabel?.text = "ID: \(alert.subjectId);  Alert: \(alert.alertTypeDescription);  Date: \(date.toString(withFormat: "MM-dd-yyyy hh:mm:ss a"))"
        }else{
            cell.textLabel?.text = "\t \(alert.subjectId): \(alert.alertTypeDescription) \t Date: N/A"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Unfinished, speak to George about how to remove alerts once they've been handled
        let cell = tableView.cellForRow(at: indexPath)
        if let cellText = cell?.textLabel?.text {
            let cellTextSplitOnColon = cellText.split(separator: ";")
            let cellTextSplitOnSpace = cellTextSplitOnColon[0].split(separator: " ")
            let extractedCageId = String(cellTextSplitOnSpace[1])
            if extractedCageId != "" {
                for cage in breedingCages {
                    if cage.id == extractedCageId {
                        displayBreedingCage(cage: cage)
                        return
                    }
                }
                for cage in sellingCages {
                    if cage.id == extractedCageId {
                        displaySellingCage(cage: cage)
                        return
                    }
                }
                for male in breedingMales {
                    let malesCurrentCage = findMalesCurrentCage(malesCurrentCageID: extractedCageId)
                    if malesCurrentCage.id == extractedCageId {
                        displayBreedingMale(male: male)
                        return
                    }
                }
            }
            else {
                let failedIDExtractionAlert = UIAlertController(title: "No Subject ID!", message: "There was an error with the subject ID for the alert you selected!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                failedIDExtractionAlert.addAction(cancelAction)
                present(failedIDExtractionAlert, animated: true, completion: nil)
            }
        }
    }
    
    func displayBreedingCage(cage: Cage) {
        let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
        if let breedingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "BreedingCage") as? breedingCageViewController {
            breedingVC.delegate = self
            breedingVC.cage = cage
            self.present(breedingVC, animated: true, completion: nil)
        }
    }
    
    func displaySellingCage(cage: Cage) {
        let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
        if let sellingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "SellingCage") as? stockCageViewController {
            sellingVC.delegate = self
            sellingVC.cage = cage
            self.present(sellingVC, animated: true, completion: nil)
        }
    }
    
    func displayBreedingMale(male: BreedingMale) {
        let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
        if let breedingMaleVC = cageViewStoryboard.instantiateViewController(withIdentifier: "BreedingMale") as? addMaleViewController {
            breedingMaleVC.delegate = self
            breedingMaleVC.breedingMale = male
            self.present(breedingMaleVC, animated: true, completion:  nil)
        }
    }
    
    func detailViewControllerDidSave(controller: UIViewController) {
        controller.dismiss(animated: true)
        //Minor detail, get selected row to deselect once controller is dismissed!
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

