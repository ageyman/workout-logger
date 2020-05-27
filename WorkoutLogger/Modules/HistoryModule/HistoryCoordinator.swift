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
        return TabItemType.history.index
    }
    
    override func configureTabBarItem(for viewController: UIViewController) -> UITabBarItem {
        let item = UITabBarItem(title: TabItemType.history.title, image: nil, selectedImage: nil)
        return item
    }
}
