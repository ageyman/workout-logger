//
//  AppDelegate.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 26.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppCoordinator()
        return true
    }
    
    private func setupAppCoordinator() {
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = TabBarCoordinator(window: window, rootViewController: UITabBarController())
        appCoordinator?.start()
    }
}
