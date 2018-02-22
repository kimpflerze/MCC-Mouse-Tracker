//
//  RackPageViewController.swift
//  MCC Mouse Reproduction Tracker
//
//  Created by Zachary Kimpfler on 11/3/17.
//  Copyright © 2017 Kimpfler Williams Novak. All rights reserved.
//

import UIKit

class RackPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    var pageCount = Settings.shared.numRacks
    var pages = [RackViewController]()
    
    var currentPage: RackViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        //Guard let statement to remove pageCount optional issues
        guard let thePageCount = pageCount else {
            return
        }
        
        //Setting up pages array to hold appropriate number RackViewControllers(Racks)
        for i in 0..<thePageCount {
            let rackVC = storyboard?.instantiateViewController(withIdentifier: "RackVC") as! RackViewController
            rackVC.rackNumber = i
            pages.append(rackVC)
        }
        
        //Sets initial view controller
        self.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        currentPage = pages[0]
        
        //Navigation Controller changes to improve layout of underlying collection view and appearance of navigation bar
        self.navigationController?.navigationBar.isTranslucent = false;
        
        //LeftBarButtonItem displays the main menu, only visible while viewing RackViewController
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = Settings.shared.masseyCancerCenterYellow
        
        //RightBarButtonItem refreshes RackViewController
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh View", style: .plain, target: self, action: #selector(refreshCollectionViewPressed(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = Settings.shared.masseyCancerCenterYellow
        
        updateNavigationControllerTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateNavigationControllerTitle() {
        self.navigationItem.title = "Rack View \(currentPage!.rackNumber + 1)"
    }
    
     @objc func menuButtonPressed(_ sender: UIBarButtonItem) {
        currentPage?.showMenu()
    }
    
     @objc func refreshCollectionViewPressed(_ sender: UIBarButtonItem) {
        currentPage?.refreshRackView()
    }

}

extension RackPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController as! RackViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let pagesCount = pages.count
        
        // User is on the last view controller and swiped right to loop tothe first view controller.
        guard pagesCount != nextIndex else {
            return pages.first
        }
        
        guard pagesCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController as! RackViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to the last view controller.
        guard previousIndex >= 0 else {
            return pages.last
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first as? RackViewController,
            let firstViewControllerIndex = pages.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let vc = pageViewController.viewControllers?[0] as? RackViewController{
            currentPage = vc
            updateNavigationControllerTitle(
            )
        }
    }
    
}


