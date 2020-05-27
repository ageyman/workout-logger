//
//  ExercisesCoordinator.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class ExercisesCoordinator: TabCoordinator {
    override var index: Int {
        return 1
    }
    
    override func configureTabBarItem(for viewController: UIViewController) -> UITabBarItem {
        let item = UITabBarItem(title: "Exercises", image: nil, selectedImage: nil)
        return item
    }
}
