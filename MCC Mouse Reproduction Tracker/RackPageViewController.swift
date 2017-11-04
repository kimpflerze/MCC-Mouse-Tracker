//
//  RackPageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/3/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class RackPageViewController: UIPageViewController {
    
    var pageCount = 3
    var pages = [RackViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<pageCount {
            let rackVC = storyboard?.instantiateViewController(withIdentifier: "RackVC") as! RackViewController
            rackVC.rackNumber = i
            pages.append(rackVC)
        }
        
        self.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- PageView Controller Data Source

}

extension RackPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? RackViewController else {
            return nil
        }
        guard let index = self.pages.index(where: { (rackVC) -> Bool in
            return rackVC.rackNumber == currentVC.rackNumber + 1
        }) else {
            return nil
        }
        return pages[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? RackViewController else {
            return nil
        }
        guard let index = self.pages.index(where: { (rackVC) -> Bool in
            return rackVC.rackNumber == currentVC.rackNumber - 1
        }) else {
            return nil
        }
        return pages[index]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        //TODO
        return 0
    }
}


