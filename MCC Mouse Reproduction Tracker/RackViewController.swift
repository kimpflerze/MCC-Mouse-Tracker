//
//  RackViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/7/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit
import MBProgressHUD

class RackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate : RackViewControllerDelegate?
    
    //Collection Views
    @IBOutlet weak var rackCollectionView: UICollectionView!
    
    //Views
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var filterView: UIView!
    
    //Image Views
    @IBOutlet weak var UserIcon: UIImageView!
    
    //Labels
    @IBOutlet weak var userNameLabel: UILabel!
    
    //Buttons
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var alertsButton: UIButton!
    @IBOutlet weak var scanCodeButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var beginFilterButton: UIButton!
    
    //Textfields
    @IBOutlet weak var filterByTextField: UITextField!
    
    
    //Settings Information
    var numColumns = Settings.shared.numColumns
    var numRows = Settings.shared.numRows
    
    //Rack Number - Used by RackPageView Controller for Navigation Controller Title
    var rackNumber = 0
    
    //Filtering options
    var filterOption = ["Clear Filters", "Breeding Cages", "Breeding Males", "Selling Cages", "Male Too Old", "Female Too Old", "Cages Assosciated With An Order", "Pups In Cage", "Pups To Wean"]
    
    var shouldApplyFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = Settings.shared.userName
        
        rackCollectionView.delegate = self
        rackCollectionView.dataSource = self
        
        //Visual changes to the menu
        menuView.layer.cornerRadius = 0
        menuView.clipsToBounds = true
        filterView.layer.cornerRadius = 10
        filterView.clipsToBounds = true
        
        filterByTextField.delegate = self
    
        let filterByTextFieldPickerView = UIPickerView()
        
        filterByTextFieldPickerView.delegate = self
        filterByTextField.inputView = filterByTextFieldPickerView
        
        //Toolbar to allow for dismissal of the picker views
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingsViewController.donePicker))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        //Assigning the toolbard created above to all of the textfields that use a pickerview.
        filterByTextField.inputAccessoryView = toolBar
        
        
        
        //Setting username and email to signify user
        if Settings.shared.userName != "" {
            userNameLabel.text = Settings.shared.userName
        }
        else {
            userNameLabel.text = "Username"
        }
//        emailLabel.text = Settings.shared.email
        
        setRackViewLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setRackViewLayout), name: NSNotification.Name(rawValue: "updatedSettings"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshRackView), name: NSNotification.Name(rawValue: "updatedSettings"), object: nil)
        
        //NEW STUFF HERE USING RACK UTILITY!
        if RackUtility.shared.firstDownloadComplete == false {
            let mouseInformationDownloadingHUD = MBProgressHUD.showAdded(to: view, animated: true)
            mouseInformationDownloadingHUD.detailsLabel.text = "Downloading mouse information..."
            
            RackUtility.shared.downloadMouseInformation { (success, error) in
                self.rackCollectionView.reloadData()
                mouseInformationDownloadingHUD.hide(animated: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.borderColor = UIColor.white.cgColor
        logoutButton.layer.cornerRadius = 5
        logoutButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.rackCollectionView.reloadData()
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        filterByTextField.text = filterOption[pickerView.selectedRow(inComponent: 0)]
    }
    
    @objc func donePicker() {
        self.view.endEditing(true)
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
        if let index = RackUtility.shared.breedingCages.index(where: { (cage) -> Bool in
            return cage.row == row + 1 && cage.column == column + 1 && cage.rack == self.rackNumber + 1
        }) {
            cell.cageTypeIcon.image = #imageLiteral(resourceName: "BreedingIconBackground")
            cell.cage = RackUtility.shared.breedingCages[index]
        }
        else if let index = RackUtility.shared.sellingCages.index(where: { (cage) -> Bool in
            return cage.row == row + 1 && cage.column == column + 1 && cage.rack == self.rackNumber + 1
        }) {
            cell.cageTypeIcon.image = #imageLiteral(resourceName: "SellingIconBackground")
            cell.cage = RackUtility.shared.sellingCages[index]
        }
        
        //Make sure all alerts are hidden prior to turning them to unhidden
        cell.maleInCageAlertIcon.isHidden = true
        cell.maleInCageAlertIcon.image = Settings.shared.maleInCageAlertIcon
        cell.pupsInCageAlertIcon.isHidden = true
        cell.pupsInCageAlertIcon.image = Settings.shared.pupsInCageAlertIcon
        cell.pupsToWeanAlertIcon.isHidden = true
        cell.pupsToWeanAlertIcon.image = Settings.shared.pupsToWeanAlertIcon
        cell.maleTooOldAlertIcon.isHidden = true
        cell.maleTooOldAlertIcon.image = Settings.shared.maleTooOldAlertIcon
        cell.FemaleTooOldAlertIcon.isHidden = true
        cell.FemaleTooOldAlertIcon.image = Settings.shared.femaleTooOldAlertIcon
        cell.cageWithOrderAlertIcon.isHidden = true
        cell.cageWithOrderAlertIcon.image = Settings.shared.cageWithOrderAlertIcon
        
        
        if let alerts = cell.cage?.alerts {
            for alert in alerts {
                print("Rack View Cage Alert Detection:")
                switch alert.alertTypeID {
                case "1":
                    print("     Pups To Wean Alert On Cage With ID: \(cell.cage?.id ?? "nil")")
                    cell.pupsToWeanAlertIcon.isHidden = false
                    break
                case "2":
                    print("     Male Too Old Alert On Cage With ID: \(cell.cage?.id ?? "nil")")
                    cell.maleTooOldAlertIcon.isHidden = false
                    break
                case "3":
                    print("     Female Too Old Alert On Cage With ID: \(cell.cage?.id ?? "nil")")
                    cell.FemaleTooOldAlertIcon.isHidden = false
                    break
                case "4":
                    print("     Cage With Order Alert On Cage With ID: \(cell.cage?.id ?? "nil")")
                    cell.cageWithOrderAlertIcon.isHidden = false
                    break
                default:
                    break
                }
            }
        }
        
        //Extra check specific to breeding cages to display the "maleInCage" icon!
        if cell.cage?.maleInCage == true {
            cell.maleInCageAlertIcon.isHidden = false
        }
        else {
            cell.maleInCageAlertIcon.isHidden = true
        }
 
        
        //Check to change opacity of cages when filtering
        if  (cell.cage?.shouldHighlightCage == false && shouldApplyFiltering == true) || cell.cage?.id == nil {
            cell.alpha = 0.3
        }
        else if (cell.cage?.shouldHighlightCage == true) {
            cell.alpha = 1
        }
        else  {
            cell.alpha = 1
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
                if let sellingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "SellingCage") as? StockCageViewController {
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
                if let sellingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "SellingCage") as? StockCageViewController {
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
            if(filterView.isHidden == false) {
                filterView.isHidden = true
            }
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
    @objc func refreshRackView() {
        //Query for all breeding cages
        let breedingCageDownloadHUD = MBProgressHUD.showAdded(to: view, animated: true)
        breedingCageDownloadHUD.detailsLabel.text = "Refreshing mouse information..."
        
        RackUtility.shared.downloadMouseInformation { (success, error) in
            self.rackCollectionView.reloadData()
            breedingCageDownloadHUD.hide(animated: true)
        }
        
        
        /*
        QueryServer.shared.getAllActiveBreedingCages { (downloadedCages, error) in
            breedingCageDownloadHUD.hide(animated: true)
            if let theCages = downloadedCages {
                RackUtility.shared.breedingCages = theCages
            }
            
            //Query for all selling cages
            let sellingCageDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            breedingCageDownloadHUD.detailsLabel.text = "Refreshing selling cages..."
            QueryServer.shared.getAllActiveSellingCages { (downloadedCages, error) in
                sellingCageDownloadHUD.hide(animated: true)
                if let theCages = downloadedCages {
                    RackUtility.shared.sellingCages = theCages
                }
                
                //Query for all breeding males
                let breedingMaleDownloadHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                breedingMaleDownloadHUD.detailsLabel.text = "Downloading breeding males..."
                QueryServer.shared.getAllActiveBreedingMales { (downloadedMales, error) in
                    breedingMaleDownloadHUD.hide(animated: true)
                    if let theMales = downloadedMales {
                        RackUtility.shared.breedingMales = theMales
                        RackUtility.shared.breedingCages = RackUtility.shared.breedingCages.map({ (cage) -> Cage in
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
        */
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
        showMenu()
        
        let alertViewStoryboard = UIStoryboard(name: "Alerts", bundle: .main)
        if let alertsVC = alertViewStoryboard.instantiateViewController(withIdentifier: "alertStoryboard") as? AlertsViewController {
            self.present(alertsVC, animated: true, completion: nil)
        }
    }
    
    //Incomplete settings button, need settings view!
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        showMenu()
        
        let cageViewStoryboard = UIStoryboard(name: "CageViews", bundle: .main)
        if let settingsVC = cageViewStoryboard.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController {
            self.present(settingsVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func filterButtonPRessed(_ sender: UIButton) {
        if(filterView.isHidden == true) {
            filterView.isHidden = false
        }
        else {
            filterView.isHidden = true
        }
    }
    
    @IBAction func beginFilterButtonPressed(_ sender: UIButton) {
        applyFilter()
        donePicker()
        showMenu()
//        shouldApplyFiltering = false
    }
    
    func showFailureToFindScannedID(failureCount: Int) {
        if (failureCount == 3) {
            let failureAlert = UIAlertController(title: "Failure to Locate Cage", message: "QR Code's value does not exist in the database. Please try again.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            failureAlert.addAction(cancelAction)
            self.present(failureAlert, animated: true, completion: nil)
        }
    }
    
    //Filtering functions
    func applyFilter() {
        clearFilters()
        shouldApplyFiltering = true
        print("Applying Filter!")
        //The switch case numbers match the alert type indexing used by the DB
        if let theFilterOption = filterByTextField.text {
            switch theFilterOption {
            case "Breeding Cages":
                breedingCagesFilter()
            case "Breeding Males":
                breedingMalesFilter()
            case "Selling Cages":
                sellingCagesFilter()
            case "Male Too Old":
                maleTooOldFilter()
            case "Female Too Old":
                femaleTooOldFilter()
            case "Cages Assosciated With An Order":
                cagesWithOrderFilter()
            case "Pups In Cage":
                pupsInCageFilter()
            case "Pups To Wean":
                pupsToWeanFilter()
            case "Clear Filters":
                clearFilters()
            default:
                print("     Error! Unknown filter option!")
            }
        }
    }
    
    func clearFilters() {
        print("All Filters Cleared!")
        for cage in RackUtility.shared.breedingCages {
            cage.shouldHighlightCage = false
        }
        for cage in RackUtility.shared.sellingCages {
            cage.shouldHighlightCage = false
        }
        for male in RackUtility.shared.breedingMales {
            male.shouldHighlightMale = false
        }
        shouldApplyFiltering = false
        self.rackCollectionView.reloadData()
    }
    
    func breedingCagesFilter() {
        print("     BreedingCagesFilter Applied!")
        for cage in RackUtility.shared.breedingCages {
            print("breedingCageID: \(cage.id)")
            cage.shouldHighlightCage = true
        }
        self.rackCollectionView.reloadData()
    }
    
    func breedingMalesFilter() {
        print("     BreedingMalesFilter Applied!")
        for male in RackUtility.shared.breedingMales {
            male.shouldHighlightMale = true
            QueryServer.shared.getBreedingCageBy(id: male.currentCageId, completion: { (cage, error) in
                DispatchQueue.main.async {
                    for breedingCage in RackUtility.shared.breedingCages {
                        if cage?.id == breedingCage.id {
                            breedingCage.shouldHighlightCage = true
                        }
                    }
                    self.rackCollectionView.reloadData()
                }
            })
        }
    }
    
    func sellingCagesFilter() {
        print("     SellingCagesFilter Applied!")
        for cage in RackUtility.shared.sellingCages {
            cage.shouldHighlightCage = true
        }
        self.rackCollectionView.reloadData()
    }
    
    func maleTooOldFilter() {
        print("     MaleTooOldFilter Applied!")
        for male in RackUtility.shared.breedingMales {
            for alert in male.alerts {
                if alert.alertTypeID == " " {
                    getCageOfMouseWith(cageID: male.id)
                }
            }
        }
        /*
        for male in breedingMales {
            switch Settings.shared.maleLifeSpanUnit {
            case 1?:
                print("  Male Lifespan Unit: Days")
                if let theDOB = male.dob {
                    let currentDate = Date()
                    print("Max of two dates: \(max(currentDate.interval(ofComponent: .day, fromDate: theDOB), Settings.shared.maleLifeSpanNumber!))")
                    if max(currentDate.interval(ofComponent: .day, fromDate: theDOB), Settings.shared.maleLifeSpanNumber!) != Settings.shared.maleLifeSpanNumber! {
                        getCageOfMouseWith(cageID: male.currentCageId)
                    }
                }
            case 2?:
                if let theDOB = male.dob {
                    let currentDate = Date()
                    if max(currentDate.interval(ofComponent: .weekOfMonth, fromDate: theDOB), Settings.shared.maleLifeSpanNumber!) != Settings.shared.maleLifeSpanNumber! {
                        getCageOfMouseWith(cageID: male.currentCageId)
                    }
                }
            case 3?:
                if let theDOB = male.dob {
                    let currentDate = Date()
                    if max(currentDate.interval(ofComponent: .month, fromDate: theDOB), Settings.shared.maleLifeSpanNumber!) != Settings.shared.maleLifeSpanNumber! {
                        getCageOfMouseWith(cageID: male.currentCageId)
                    }
                }
            case 4?:
                if let theDOB = male.dob {
                    let currentDate = Date()
                    if max(currentDate.interval(ofComponent: .year, fromDate: theDOB), Settings.shared.maleLifeSpanNumber!) != Settings.shared.maleLifeSpanNumber! {
                        getCageOfMouseWith(cageID: male.currentCageId)
                    }
                }
            default:
                print("Error! Unable to determine male life span unit! Please reset that value in the settings!")
                
            }
        }
 */
    }
    
    //Utility function
    func getCageOfMouseWith(cageID: String) {
        QueryServer.shared.getBreedingCageBy(id: cageID, completion: { (cage, error) in
            DispatchQueue.main.async {
                for breedingCage in RackUtility.shared.breedingCages {
                    if cage?.id == cageID {
                        breedingCage.shouldHighlightCage = true
                    }
                }
                self.rackCollectionView.reloadData()
            }
        })
    }
    
    func femaleTooOldFilter() {
        print("     FemaleTooOldFilter Applied!")
        for breedingCage in RackUtility.shared.breedingCages {
            for alert in breedingCage.alerts {
                if alert.alertTypeID == "3" {
                    breedingCage.shouldHighlightCage = true
                }
            }
        }

        self.rackCollectionView.reloadData()
    }
    
    func cagesWithOrderFilter() {
        print("     CagesWithOrderFilter Applied!")
        for sellingCage in RackUtility.shared.sellingCages {
            if sellingCage.markedForOrder {
                sellingCage.shouldHighlightCage = true
            }
        }
        
        self.rackCollectionView.reloadData()
    }
    
    func pupsInCageFilter() {
        print("     PupsInCageFilter Applied!")
        QueryServer.shared.getAllLitterLogs { (litterLogs, error) in
            DispatchQueue.main.async {
                if let theLitterLogs = litterLogs {
                    for log in litterLogs! {
                        for breedingCage in RackUtility.shared.breedingCages {
                            if log.motherCageId == breedingCage.id {
                                breedingCage.shouldHighlightCage = true
                            }
                        }
                    }
                    self.rackCollectionView.reloadData()
                }
            }
        }
    }
    
    func pupsToWeanFilter() {
        print("     PupsToWeanFilter Applied!")
        for cage in RackUtility.shared.breedingCages {
            for alert in cage.alerts {
                if alert.alertTypeID == String(1) {
                    cage.shouldHighlightCage = true
                }
            }
        }
        self.rackCollectionView.reloadData()
    }
    
}

//Extension to handle return from QRScannerController called from the menu
extension RackViewController: QRScannerControllerDelegate {
    
    //Function below presents proper view controller depending on scanned cage's type
    func qrScannerController(controller: QRScannerController, didScanQRCodeWith value: String) {
        print("QR Scanner Return:")
        print("     Cage ID Recieved from Scanner! Id: \(value)")
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
                    if let sellingVC = cageViewStoryboard.instantiateViewController(withIdentifier: "SellingCage") as? StockCageViewController {
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
                    if let breedingMaleVC = cageViewStoryboard.instantiateViewController(withIdentifier: "BreedingMale") as? AddMaleViewController {
                        breedingMaleVC.delegate = self
                        breedingMaleVC.breedingMale = male
                        if let indexTwo = RackUtility.shared.breedingCages.index(where: { (cage) -> Bool in
                            return cage.id == theMale.currentCageId
                        }) {
                            breedingMaleVC.breedingMaleCurrentCage = RackUtility.shared.breedingCages[indexTwo]
                            self.present(breedingMaleVC, animated: true, completion:  nil)
                        }
                    }
                }
                else {
                    responseFailureCounter += 1
                    self.showFailureToFindScannedID(failureCount: responseFailureCounter)
                }
            })
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

extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
}

protocol RackViewControllerDelegate {
    func rackViewController(controller : RackViewController, didSelectCage cage : Cage?)
}
