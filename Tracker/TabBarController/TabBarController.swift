//
//  SplachScreenController.swift
//  Tracker
//
//  Created by Gleb on 01.06.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = .white
        view.backgroundColor = .white
        
        setupTabBar()
    }
    
    // MARK: - Private Methods
    private func setupTabBar() {
        let trackerViewController = TrackerViewController()
        trackerViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("trackers", comment: ""),
            image: UIImage(named: "trackerTabBarActive"),
            selectedImage: nil
        )
        
        let navigationViewController = UINavigationController(rootViewController: trackerViewController)
        
        let statisticsViewController = StatisticsViewController()
        statisticsViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("statistics", comment: ""),
            image: UIImage(named: "statisticsTabBarNotActive"),
            selectedImage: nil
        )
        
        self.tabBar.barTintColor = .white
        self.viewControllers = [ navigationViewController, statisticsViewController]
    }
}
