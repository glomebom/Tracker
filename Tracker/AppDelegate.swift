//
//  AppDelegate.swift
//  Tracker
//
//  Created by Gleb on 01.06.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ///
//        window = UIWindow()
//        window?.rootViewController = ViewController()
//        window?.makeKeyAndVisible()
        ///
        
        return true
    }
    
    //MARK: UISceneSession Lifecycle
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
        ///
//        let sceneConfiguration = UISceneConfiguration(
//            name: nil,
//            sessionRole: connectingSceneSession.role
//        )
//        sceneConfiguration.storyboard = nil
//        sceneConfiguration.sceneClass = UIWindowScene.self
//        sceneConfiguration.delegateClass = SceneDelegate.self
//        return sceneConfiguration
        ///
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

