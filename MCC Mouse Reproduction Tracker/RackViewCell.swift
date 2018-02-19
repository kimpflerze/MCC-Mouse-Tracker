//
//  RackViewCell.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 10/29/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class RackViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cageTypeIcon: UIImageView!
    @IBOutlet weak var cagePositionLabel: UILabel!
    
    @IBOutlet weak var maleInCageAlertIcon: UIImageView!
    @IBOutlet weak var pupsInCageAlertIcon: UIImageView!
    @IBOutlet weak var pupsToWeanAlertIcon: UIImageView!
    @IBOutlet weak var maleTooOldAlertIcon: UIImageView!
    @IBOutlet weak var FemaleTooOldAlertIcon: UIImageView!
    @IBOutlet weak var cageWithOrderAlertIcon: UIImageView!
    
    var cage: Cage?
    
}
