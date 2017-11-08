//
//  RackViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/7/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class RackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var rackCollectionView: UICollectionView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var UserIcon: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var alertsButton: UIButton!
    @IBOutlet weak var scanCodeButton: UIButton!
    @IBOutlet weak var serttingsButton: UIButton!
    
    var numColumns = 6
    var numRows = 10
    
    var breedingCages = [Cage]()
    var sellingCages = [Cage]()
    
    var rackNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rackCollectionView.delegate = self
        rackCollectionView.dataSource = self
        
        menuView.layer.cornerRadius = 10
        menuView.clipsToBounds = true
        
        userNameLabel.text = Settings.shared.userName
        emailLabel.text = Settings.shared.email
        
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: numColumns,
            minimumInteritemSpacing: 20,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        )
        
        rackCollectionView.collectionViewLayout = columnLayout
        
        //Query for all breeding cages
        QueryServer.shared.getAllBreedingCages { (downloadedCages, error) in
            if let theCages = downloadedCages {
                self.breedingCages = theCages
                DispatchQueue.main.async {
                    self.rackCollectionView.reloadData()
                }
            }
        }
        
        //Query for all selling cages
        QueryServer.shared.getAllSellingCages { (downloadedCages, error) in
            if let theCages = downloadedCages {
                self.sellingCages = theCages
                DispatchQueue.main.async {
                    self.rackCollectionView.reloadData()
                }
            }
        }
        
        //Need to query settings table for number of rows and columns, or should it be saved to local data and only all settings checked at app launch?
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numRows*numColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cage", for: indexPath) as! RackViewCell
        
        cell.cageTypeIcon.image = #imageLiteral(resourceName: "GenericIconBackground")
        let row = indexPath.item / numColumns
        let column = indexPath.item % numColumns
        
        cell.cagePositionLabel.text = "\(row + 1) : \(column + 1)"
        
        //Check what type of cage should be put into what column/row
        if let _ = breedingCages.index(where: { (cage) -> Bool in
            return cage.row == row + 1 && cage.column == column + 1 && cage.rack == self.rackNumber + 1
        }) {
            //            let cage = breedingCages[index]
            cell.cageTypeIcon.image = #imageLiteral(resourceName: "BreedingIconBackground")
        }
        if let _ = sellingCages.index(where: { (cage) -> Bool in
            return cage.row == row + 1 && cage.column == column + 1 && cage.rack == self.rackNumber + 1
        }) {
            //            let cage = sellingCages[index]
            cell.cageTypeIcon.image = #imageLiteral(resourceName: "SellingIconBackground")
        }
        
        //Stuff just to check spacing of icons
        cell.maleInCageIcon.isHidden = false
        cell.oldAgeIcon.isHidden = false
        cell.weanCageIcon.isHidden = false
        
        return cell
    }
    
    func showMenu() {
        if(menuView.isHidden == true) {
            menuView.isHidden = false
        }
        else {
            menuView.isHidden = true
        }
    }
    
    func refreshRackView() {
        //Query for all breeding cages
        QueryServer.shared.getAllBreedingCages { (downloadedCages, error) in
            if let theCages = downloadedCages {
                self.breedingCages = theCages
                print("Refreshed the breeding cages!")
            }
        }
        
        //Query for all selling cages
        QueryServer.shared.getAllSellingCages { (downloadedCages, error) in
            if let theCages = downloadedCages {
                self.sellingCages = theCages
                print("Refreshed the selling cages!")
            }
        }
        
        rackCollectionView.reloadData()
        
        let loginErrorAlert = UIAlertController(title: "Data Refreshed", message: "The cage data was refreshed successfully.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        loginErrorAlert.addAction(cancelAction)
        self.present(loginErrorAlert, animated: true, completion: nil)

    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let logoutConfirmationAlert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (alert) in
            print("Clear username and email from shared settings")
            Settings.shared.userName = ""
            Settings.shared.email = ""
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        logoutConfirmationAlert.addAction(cancelAction)
        logoutConfirmationAlert.addAction(confirmAction)
        self.present(logoutConfirmationAlert, animated: true, completion: nil)
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
