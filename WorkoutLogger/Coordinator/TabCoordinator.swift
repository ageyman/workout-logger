//
//  TabCoordinator.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class TabCoordinator: Coordinator {
    private let navigationController: UINavigationController
    var index: Int {
        return 0
    }
    
    private var tabBarItem: UITabBarItem {
        let item = configureTabBarItem(for: viewController)
        item.tag = index
        return item
    }
    
    private let viewController: UIViewController
    
    init(navigationController: UINavigationController = UINavigationController(),
         viewController: UIViewController) {
        self.navigationController = navigationController
        self.viewController = viewController
    }
    
    override func start() {
        viewController.tabBarItem = tabBarItem
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func configureTabBarItem(for viewController: UIViewController) -> UITabBarItem {
        preconditionFailure("\(#function) should be overriden by subclass!")
    }
}
