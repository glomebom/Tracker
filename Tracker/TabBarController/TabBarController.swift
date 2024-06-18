//
//  SplachScreenController.swift
//  Tracker
//
//  Created by Gleb on 01.06.2024.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = .white
        view.backgroundColor = .white
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        let trackerViewController = TrackerViewController()
        trackerViewController.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "trackerTabBarActive"),
            selectedImage: nil
        )
        
        let navigationViewController = UINavigationController(rootViewController: trackerViewController)
        
        let statisticsViewController = StatisticsViewController()
        statisticsViewController.tabBarItem = UITabBarItem(
            title: "Статитстика",
            image: UIImage(named: "statisticsTabBarNotActive"),
            selectedImage: nil
        )
        
        self.tabBar.barTintColor = .white
        self.viewControllers = [ navigationViewController, statisticsViewController]
    }
}
