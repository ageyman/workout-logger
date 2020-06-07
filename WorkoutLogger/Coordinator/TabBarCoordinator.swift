//
//  TabBarCoordinator.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    private let rootViewController: UITabBarController
    private let window: UIWindow?
    private var tabCoordinators = [TabCoordinator]()
    
    init(window: UIWindow?, rootViewController: UITabBarController) {
        self.window = window
        self.rootViewController = rootViewController
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    override func start() {
        setupChildCoordinators()
        rootViewController.selectedIndex = 0
    }
    
    private func setupChildCoordinators() {
        
        // AddWorkout
        let addWorkoutVC = AddWorkoutVC.create()
        let addWorkoutCoordinator = AddWorkoutCoordinator(viewController: addWorkoutVC)
        tabCoordinators.append(addWorkoutCoordinator)
        
        // Exercises
        let exercisesVC = ExercisesVC.instantiateFromStoryboard()
        let exercisesCoordinator = ExercisesCoordinator(viewController: exercisesVC)
        tabCoordinators.append(exercisesCoordinator)
        
        // History
        let historyVC = HistoryVC.instantiateFromStoryboard()
        let historyCoordinator = HistoryCoordinator(viewController: historyVC)
        tabCoordinators.append(historyCoordinator)
        
        addChildCoordinators(tabCoordinators)
        childCoordinators.forEach { $0.start() }
        rootViewController.viewControllers = tabCoordinators.map {$0.rootViewController}
    }
}
