//
//  RackViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 10/29/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cage"

class RackViewController: UICollectionViewController {
    
    var numColumns = 6
    var numRows = 10
    
    var cages = [Cage]()
    var rackNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        print("Now viewing: RackViewController")
        
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: numColumns,
            minimumInteritemSpacing: 20,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        )
        
        self.collectionView?.collectionViewLayout = columnLayout
        
        QueryServer.shared.getAllBreedingCages { (downloadedCages, error) in
            if let theCages = downloadedCages {
                self.cages = theCages
                DispatchQueue.main.async {
                     self.collectionView?.reloadData()
                }
            }
        }
        
        //Need to query settings table for number of rows and columns, or should it be saved to local data and only all settings checked at app launch?
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return numRows * numColumns
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cage", for: indexPath) as! RackViewCell
        
        cell.cageTypeIcon.image = #imageLiteral(resourceName: "GenericIconBackground")
        let row = indexPath.item / numColumns
        let column = indexPath.item % numColumns
        print("row: \(row), column: \(column), rack: \(rackNumber)")
        if let index = cages.index(where: { (cage) -> Bool in
            return cage.row == row && cage.column == column && cage.rack == self.rackNumber
        }) {
            //Add if statement for the selling cages here!
            let cage = cages[index]
            cell.cageTypeIcon.image = #imageLiteral(resourceName: "BreedingIconBackground")
            
        }
        
        //Stuff just to check spacing of icons
        cell.maleInCageIcon.isHidden = false
        cell.oldAgeIcon.isHidden = false
        cell.weanCageIcon.isHidden = false
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
