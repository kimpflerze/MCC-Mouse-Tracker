//
//  RackViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/7/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD

class RackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var delegate : RackViewControllerDelegate?
    
    //Collection Views
    @IBOutlet weak var rackCollectionView: UICollectionView!
    
    //Views
    @IBOutlet weak var menuView: UIView!
    
    //Image Views
    @IBOutlet weak var UserIcon: UIImageView!
    
    //Labels
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    //Buttons
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var alertsButton: UIButton!
    @IBOutlet weak var ordersButton: UIButton!
    @IBOutlet weak var scanCodeButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    
    //Settings Information
    var numColumns = Settings.shared.numColumns
    var numRows = Settings.shared.numRows
    
    //Downloaded Cages - Cages downloaded below
    var breedingCages = [Cage]()
    var sellingCages = [Cage]()
    var breedingMales = [BreedingMale]()
    
    //Rack Number - Used by RackPageView Controller for Navigation Controller Title
    var rackNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[TO-DO] Fix male in cage icon moving around after refreshing view")
        
        rackCollectionView.delegate = self
        rackCollectionView.dataSource = self
        
        //Visual changes to the menu
        menuView.layer.cornerRadius = 10
        menuView.clipsToBounds = true
        
        //Setting username and email to signify user
        userNameLabel.text = Settings.shared.userName
        emailLabel.text = Settings.shared.email
        
        setRackViewLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setRackViewLayout), name: NSNotification.Name(rawValue: "updatedSettings"), object: nil)
        
        //Query for all breeding cages
        let breedingCageDownloadHUD = MBProgressHUD.showAdded(to: view, animated: true)
        breedingCageDownloadHUD.detailsLabel.text = "Downloading breeding cages..."
        
        QueryServer.shared.getAllActiveBreedingCages { (downloadedCages, error) in
            breedingCageDownloadHUD.hide(animated: true)
            if let theCages = downloadedCages {
                self.breedingCages = theCages
                DispatchQueue.main.async {
                    
                    //Query for all selling cages
                    let sellingCageDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                    sellingCageDownloadHUD.detailsLabel.text = "Downloading selling cages..."
                    
                    QueryServer.shared.getAllActiveSellingCages { (downloadedCages, error) in
                        sellingCageDownloadHUD.hide(animated: true)
                        if let theCages = downloadedCages {
                            self.sellingCages = theCages
                            DispatchQueue.main.async {
                                
                                //Query for all breeding males
                                let breedingMaleDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                                breedingMaleDownloadHUD.detailsLabel.text = "Downloading breeding males..."
                                QueryServer.shared.getAllActiveBreedingMales { (downloadedMales, error) in
                                    breedingMaleDownloadHUD.hide(animated: true)
                                    if let theMales = downloadedMales {
                                        self.breedingMales = theMales
                                        self.breedingCages = self.breedingCages.map({ (cage) -> Cage in
                                            let newCage = cage
                                            newCage.maleInCage = theMales.contains(where: { (male) -> Bool in
                                                cage.maleInCage = true
                                                return male.currentCageId == cage.id
                                            })
                                            return newCage
                                        })
                                        DispatchQueue.main.async {
                                            self.rackCollectionView.reloadData()
                                            
                                            /*
                                            //Query for all alerts
                                            let alertsDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                                            alertsDownloadHUD.detailsLabel.text = "Downloading alerts for cages..."
                                            QueryServer.shared.getAlerts { (downloadedAlerts, error) in
                                                if let theAlerts = downloadedAlerts {
                                                    for alert in theAlerts {
                                                        
                                                        //Setting the alert icons on all cage cells
                                                        if let index = self.breedingCages.index(where: { (cage) -> Bool in
                                                            return alert.subjectId == cage.id
                                                        }) {
                                                            switch alert.alertTypeID {
                                                            case "1":
                                                                self.breedingCages[index].mouseTooOld = true
                                                            case "2":
                                                                self.breedingCages[index].needsToBeWeaned = true
                                                            default:
                                                                print("Default case, should never fire")
                                                            }
                                                            
                                                        }
                                                        if let index = self.sellingCages.index(where: { (cage) -> Bool in
                                                            return alert.subjectId == cage.id
                                                        }) {
                                                            switch alert.alertTypeID {
                                                            case "1":
                                                                self.sellingCages[index].mouseTooOld = true
                                                            case "2":
                                                                self.sellingCages[index].needsToBeWeaned = true
                                                            default:
                                                                print("Default case, should never fire")
                                                            }
                                                            
                                                        }
                                                    }
                                                    alertsDownloadHUD.hide(animated: true)
                                                    self.rackCollectionView.reloadData()
                                                }
                                            }
                                            */
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func uiColorToIconImage(color: UIColor) -> UIImage {
        switch color {
        case UIColor.red:
            return #imageLiteral(resourceName: "RedDot")
        case UIColor.orange:
            return #imageLiteral(resourceName: "OrangeDot")
        case UIColor.yellow:
            return #imageLiteral(resourceName: "YellowDot")
        case UIColor.green:
            return #imageLiteral(resourceName: "GreenDot")
        case UIColor.cyan:
            return #imageLiteral(resourceName: "CyanDot")
        case UIColor.blue:
            return #imageLiteral(resourceName: "BlueDot")
        case UIColor.purple:
            return #imageLiteral(resourceName: "PurpleDot")
        case UIColor.magenta:
            return #imageLiteral(resourceName: "PinkDot")
        default:
            return #imageLiteral(resourceName: "XIcon")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numRows! * numColumns!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cage", for: indexPath) as! RackViewCell
        
        //Setting generic cage icon image
        cell.cageTypeIcon.image = #imageLiteral(resourceName: "GenericIconBackground")
        
        //Determining the number of rows and columns
        let row = indexPath.item / numColumns!
        let column = indexPath.item % numColumns!
        
        //Setting cell information below
        cell.cagePositionLabel.text = "\(row + 1) : \(column + 1)"
        
        //Clearing cells stored cage before assigning proper cage type icon
        cell.cage = nil
        
        //Check what type of cage should be put into what column/row
        if let index = breedingCages.index(where: { (cage) -> Bool in
            return cage.row == row + 1 && cage.column == column + 1 && cage.rack == self.rackNumber + 1
        }) {
            cell.cageTypeIcon.image = #imageLiteral(resourceName: "BreedingIconBackground")
            cell.cage = breedingCages[index]
        }
        else if let index = sellingCages.index(where: { (cage) -> Bool in
            return cage.row == row + 1 && cage.column == column + 1 && cage.rack == self.rackNumber + 1
        }) {
            cell.cageTypeIcon.image = #imageLiteral(resourceName: "SellingIconBackground")
            cell.cage = sellingCages[index]
        }
        
        //Make sure all alerts are hidden prior to turning them to unhidden
        cell.maleInCageAlertIcon.isHidden = true
        cell.maleInCageAlertIcon.image = uiColorToIconImage(color: Settings.shared.maleInCageAlertColor!)
        cell.pupsInCageAlertIcon.isHidden = true
        cell.pupsInCageAlertIcon.image = uiColorToIconImage(color: Settings.shared.pupsInCageAlertColor!)
        cell.pupsToWeanAlertIcon.isHidden = true
        cell.pupsToWeanAlertIcon.image = uiColorToIconImage(color: Settings.shared.pupsToWeanAlertColor!)
        cell.maleTooOldAlertIcon.isHidden = true
        cell.maleTooOldAlertIcon.image = uiColorToIconImage(color: Settings.shared.maleTooOldAlertColor!)
        cell.FemaleTooOldAlertIcon.isHidden = true
        cell.FemaleTooOldAlertIcon.image = uiColorToIconImage(color: Settings.shared.femaleTooOldAlertColor!)
        cell.cageWithOrderAlertIcon.isHidden = true
        cell.cageWithOrderAlertIcon.image = uiColorToIconImage(color: Settings.shared.cageWithOrderAlertColor!)
        
        if let alerts = cell.cage?.alerts {
            for alert in alerts {
                switch alert.alertTypeID {
                case "1":
                    print("Case one")
                    cell.pupsToWeanAlertIcon.isHidden = false
                    break
                case "2":
                    print("Case two")
                    cell.maleTooOldAlertIcon.isHidden = false
                    break
                case "3":
                    print("Case three")
                    cell.FemaleTooOldAlertIcon.isHidden = false
                    break
                case "4":
                    print("Case four")
                    cell.cageWithOrderAlertIcon.isHidden = false
                    break
                default:
                    break
                }
            }
        }
        
        //Extra check specific to breeding cages to display the "maleInCage" icon!
        if cell.cage?.maleInCage == true {
//            cell.maleInCageAlertIcon.image = self.uiColorToIconImage(color: Settings.shared.maleInCageAlertColor!)
            cell.maleInCageAlertIcon.isHidden = false
        }
        else {
            cell.maleInCageAlertIcon.isHidden = true
        }
        
        //Check to change opacity of cages when filtering
        if cell.cage?.shouldHighlightCage == false || cell.cage?.id == nil {
            cell.alpha = 1
        }
        else  {
            cell.alpha = 0.3
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? RackViewCell
        var cage = cell?.cage

        if let theDelegate = delegate {
            theDelegate.rackViewController(controller: self, didSelectCage: cage)
            return
        }
        
        //Determining if the cell has an assigned cage or if its a blank cell
        if let theCage = cell?.cage {
            //Selected a cage that already exists
            if(theCage.isBreeding) {
                let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                if let breedingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "BreedingCage") as? breedingCageViewController {
                    breedingVC.cage = theCage
                    breedingVC.isNewCage = false
                    breedingVC.delegate = self
                    self.present(breedingVC, animated: true, completion: nil)
                }
            }
            else {
                let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                if let sellingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "SellingCage") as? stockCageViewController {
                    sellingVC.cage = theCage
                    sellingVC.isNewCage = false
                    sellingVC.delegate = self
                    self.present(sellingVC, animated: true, completion: nil)
                }
            }
        }
        else {
            //Selected an empty cage
            
            //Instantiating a cage so row, rack, and column values can be set before pushing to appropriate VC
            if(cage == nil) {
                cage = Cage(rackInfo: [:])
            }
            
            //Setting cage row, rack, and column values
            cage?.row = indexPath.item / numColumns! + 1
            cage?.column = indexPath.item % numColumns! + 1
            cage?.rack = self.rackNumber + 1
            
            //Alert to select what cage type user wants to create then presents appropriate VC
            let emptyCageTappedAlert = UIAlertController(title: "Empty Cage", message: "The cage you selected is currently empty, what type of cage would you like to insert here?", preferredStyle: .alert)
            let breedingAction = UIAlertAction(title: "Breeding", style: .default) { (alert) in
                let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                if let breedingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "BreedingCage") as? breedingCageViewController {
                    breedingVC.cage = cage
                    breedingVC.isNewCage = true
                    breedingVC.delegate = self
                    self.present(breedingVC, animated: true, completion: nil)
                }
            }
            let sellingAction = UIAlertAction(title: "Selling", style: .default) { (alert) in
                let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                if let sellingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "SellingCage") as? stockCageViewController {
                    sellingVC.cage = cage
                    sellingVC.isNewCage = true
                    sellingVC.delegate = self
                    //Dont forget the sellingVC delegate just like the breedingVC!
                    self.present(sellingVC, animated: true, completion: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            emptyCageTappedAlert.addAction(breedingAction)
            emptyCageTappedAlert.addAction(sellingAction)
            emptyCageTappedAlert.addAction(cancelAction)
            self.present(emptyCageTappedAlert, animated: true, completion: nil)
        }
    }
    
    //Utility function to show and hide the menu on button press
    func showMenu() {
        if(menuView.isHidden == true) {
            menuView.isHidden = false
        }
        else {
            menuView.isHidden = true
        }
    }
    
    @objc func setRackViewLayout() {
        //Setting collection view layout
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: Settings.shared.numColumns!,
            minimumInteritemSpacing: 20,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        )
        
        rackCollectionView.collectionViewLayout = columnLayout
    }
    
    //Function to refresh the cage information in the collection view - with completion alert!
    func refreshRackView() {
        //Query for all breeding cages
        let breedingCageDownloadHUD = MBProgressHUD.showAdded(to: view, animated: true)
        breedingCageDownloadHUD.detailsLabel.text = "Refreshing breeding cages..."
        QueryServer.shared.getAllActiveBreedingCages { (downloadedCages, error) in
            breedingCageDownloadHUD.hide(animated: true)
            if let theCages = downloadedCages {
                self.breedingCages = theCages
            }
            
            //Query for all selling cages
            let sellingCageDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            breedingCageDownloadHUD.detailsLabel.text = "Refreshing selling cages..."
            QueryServer.shared.getAllActiveSellingCages { (downloadedCages, error) in
                sellingCageDownloadHUD.hide(animated: true)
                if let theCages = downloadedCages {
                    self.sellingCages = theCages
                }
                
                //Query for all breeding males
                let breedingMaleDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                breedingMaleDownloadHUD.detailsLabel.text = "Downloading breeding males..."
                QueryServer.shared.getAllActiveBreedingMales { (downloadedMales, error) in
                    breedingMaleDownloadHUD.hide(animated: true)
                    if let theMales = downloadedMales {
                        self.breedingMales = theMales
                        self.breedingCages = self.breedingCages.map({ (cage) -> Cage in
                            let newCage = cage
                            newCage.maleInCage = theMales.contains(where: { (male) -> Bool in
                                cage.maleInCage = true
                                return male.currentCageId == cage.id
                            })
                            return newCage
                        })
                        DispatchQueue.main.async {
                                    self.rackCollectionView.reloadData()
                                }
                        
                            }
                            
                        }
                
                let refreshCollectionViewAlert = UIAlertController(title: "Data Refreshed", message: "The cage data was refreshed successfully.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                refreshCollectionViewAlert.addAction(cancelAction)
                self.present(refreshCollectionViewAlert, animated: true, completion: nil)
            }
        }
    }
    
    func highlightCages() {
        
    }
            
    //User logout action - with alert
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let logoutConfirmationAlert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (alert) in
            Settings.shared.userName = ""
            Settings.shared.email = ""
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        logoutConfirmationAlert.addAction(cancelAction)
        logoutConfirmationAlert.addAction(confirmAction)
        showMenu()
        self.present(logoutConfirmationAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "rackViewToScanner") {
            if let qrScannerVC = segue.destination as? QRScannerController {
                qrScannerVC.delegate = self
            }
        }
    }
    
    //Incomplete alerts button, need alerts view!
    @IBAction func alertsButtonPressed(_ sender: UIButton) {
        print("[TO_DO] Complete alerts button in RackViewController.swift!")
        showMenu()
        
        let alertViewStoryboard = UIStoryboard(name: "Alerts", bundle: .main)
        if let alertsVC = alertViewStoryboard.instantiateViewController(withIdentifier: "alertStoryboard") as? AlertsViewController {
            self.present(alertsVC, animated: true, completion: nil)
        }
    }
    
    //Incomplete settings button, need settings view!
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        print("[TO-DO] Complete settings button in RackViewController.swift!")
        showMenu()
        
        let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
        if let settingsVC = cageViewStoryboard.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController {
            self.present(settingsVC, animated: true, completion: nil)
        }
    }
    
    func showFailureToFindScannedID(failureCount: Int) {
        if (failureCount == 3) {
            let failureAlert = UIAlertController(title: "Failure to Locate Cage", message: "QR Code's value does not exist in the database. Please try again.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            failureAlert.addAction(cancelAction)
            self.present(failureAlert, animated: true, completion: nil)
        }
    }
    
}

//Extension to handle return from QRScannerController called from the menu
extension RackViewController: QRScannerControllerDelegate {
    
    //Function below presents proper view controller depending on scanned cage's type
    func qrScannerController(controller: QRScannerController, didScanQRCodeWith value: String) {
        print("Cage ID Recieved from Scanner! Id: \(value)")
        controller.dismiss(animated: true) {
            var responseFailureCounter = 0
            //Check if returned ID is a breeding cage
            QueryServer.shared.getBreedingCageBy(id: value, completion: { (cage, error) in
                if let theCage = cage {
                    //Found the cage
                    let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                    if let breedingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "BreedingCage") as? breedingCageViewController {
                        breedingVC.delegate = self
                        breedingVC.cage = theCage
                        self.present(breedingVC, animated: true, completion: nil)
                    }
                }
                else {
                    responseFailureCounter += 1
                    self.showFailureToFindScannedID(failureCount: responseFailureCounter)
                }
            })
            QueryServer.shared.getSellingCageBy(id: value, completion: { (cage, error) in
                if let theCage = cage {
                    //Found the cage
                    let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                    if let sellingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "SellingCage") as? stockCageViewController {
                        sellingVC.delegate = self
                        sellingVC.cage = theCage
                        self.present(sellingVC, animated: true, completion: nil)
                    }
                }
                else {
                    responseFailureCounter += 1
                    self.showFailureToFindScannedID(failureCount: responseFailureCounter)
                }
            })
            QueryServer.shared.getBreedingMaleBy(id: value, completion: { (male, error) in
                if let theMale = male {
                    //Found the male
                    let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                    if let breedingMaleVC = cageViewStoryboard.instantiateViewController(withIdentifier: "BreedingMale") as? addMaleViewController {
                        breedingMaleVC.delegate = self
                        breedingMaleVC.breedingMale = male
                        if let indexTwo = self.breedingCages.index(where: { (cage) -> Bool in
                            return cage.id == theMale.currentCageId
                        }) {
                            breedingMaleVC.breedingMaleCurrentCage = self.breedingCages[indexTwo]
                            self.present(breedingMaleVC, animated: true, completion:  nil)
                        }
                    }
                }
                else {
                    responseFailureCounter += 1
                    self.showFailureToFindScannedID(failureCount: responseFailureCounter)
                }
            })
            
            
            
            //Find the cage object
            /*
            let allCages = self.breedingCages + self.sellingCages
            if let index = allCages.index(where: { (cage) -> Bool in
                return cage.id == value
            }) {
                let cage = allCages[index]
                if(cage.isBreeding) {
                    let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                    if let breedingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "BreedingCage") as? breedingCageViewController {
                        breedingVC.cage = cage
                        self.present(breedingVC, animated: true, completion: nil)
                    }
                }
                else {
                    let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                    if let sellingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "SellingCage") as? stockCageViewController {
                        sellingVC.cage = cage
                        self.present(sellingVC, animated: true, completion: nil)
                    }
                }

            }
            else {
                if let index = self.breedingMales.index(where: { (male) -> Bool in
                    return male.id == value
                }) {
                    let male = self.breedingMales[index]
                    let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
                    if let breedingMaleVC = cageViewStoryboard.instantiateViewController(withIdentifier: "BreedingMale") as? addMaleViewController {
                        breedingMaleVC.breedingMale = male
                        if let indexTwo = self.breedingCages.index(where: { (cage) -> Bool in
                            return cage.id == male.currentCageId
                        }) {
                            breedingMaleVC.breedingMaleCurrentCage = self.breedingCages[indexTwo]
                            self.present(breedingMaleVC, animated: true, completion:  nil)
                        }
                    }
                }
            }
            */
        }
    }
}

//Extension to handle completion - Need to find where this is used!
extension RackViewController: DetailViewControllerDelegate {
    func detailViewControllerDidSave(controller: UIViewController) {
        controller.dismiss(animated: true) {
            self.refreshRackView()
        }
    }
}

protocol RackViewControllerDelegate {
    func rackViewController(controller : RackViewController, didSelectCage cage : Cage?)
}
