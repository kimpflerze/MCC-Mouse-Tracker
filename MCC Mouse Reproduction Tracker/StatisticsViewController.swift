//
//  StatisticsViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Adrianne Williams on 3/5/18.
//  Copyright © 2018 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    // UI Variables
    @IBOutlet weak var totalBreedingCagesLabel: UILabel!
    @IBOutlet weak var totalLittersLabel: UILabel!
    @IBOutlet weak var totalSellingCagesLabel: UILabel!
    
    @IBOutlet weak var totalStockMice: UILabel!
    @IBOutlet weak var totalStockMales: UILabel!
    @IBOutlet weak var totalStockFemales: UILabel!
    @IBOutlet weak var totalBreedingMales: UILabel!
    
    @IBOutlet weak var totalOrders: UILabel!
    @IBOutlet weak var totalMalesOrdered: UILabel!
    @IBOutlet weak var totalFemalesOrdered: UILabel!
    
    @IBOutlet weak var exitButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* Load Statistics information s*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * When button is pressed return to the rackView.
     */
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        //return to rackView
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
