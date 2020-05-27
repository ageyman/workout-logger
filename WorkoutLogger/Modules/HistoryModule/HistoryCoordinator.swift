//
//  HistoryCoordinator.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class HistoryCoordinator: TabCoordinator {
    override var index: Int {
        return 2
    }
    
    override func configureTabBarItem(for viewController: UIViewController) -> UITabBarItem {
        let item = UITabBarItem(title: "History", image: nil, selectedImage: nil)
        return item
    }
}
