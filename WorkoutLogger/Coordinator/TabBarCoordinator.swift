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
    private var viewControllers = [UIViewController]()
    
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
        
        func append(coordinator: TabCoordinator, viewController: UIViewController) {
            tabCoordinators.append(coordinator)
            viewControllers.append(viewController)
        }
        
        // AddWorkout
        let addWorkoutVC = AddWorkoutVC.create()
        let addWorkoutCoordinator = AddWorkoutCoordinator(viewController: addWorkoutVC)
        append(coordinator: addWorkoutCoordinator, viewController: addWorkoutVC)
        
        // Exercises
        let exercisesVC = ExercisesVC.instantiateFromStoryboard()
        let exercisesCoordinator = ExercisesCoordinator(viewController: exercisesVC)
        append(coordinator: exercisesCoordinator, viewController: exercisesVC)
        
        // History
        let historyVC = HistoryVC.instantiateFromStoryboard()
        let historyCoordinator = HistoryCoordinator(viewController: historyVC)
        append(coordinator: historyCoordinator, viewController: historyVC)
        
        addChildCoordinators(tabCoordinators)
        childCoordinators.forEach { $0.start() }
        rootViewController.viewControllers = viewControllers
    }
}
