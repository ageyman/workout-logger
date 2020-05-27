//
//  TabBarCoordinator.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    private let window: UIWindow?
    private let rootViewController: UITabBarController
    
    init(window: UIWindow?, rootViewController: UITabBarController) {
        self.window = window
        self.rootViewController = rootViewController
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    override func start() {
        
    }
}
