//
//  Coordinator.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 26.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private weak var parentCoordinator: Coordinator?
    
    func start() {
        preconditionFailure("\(#function) should be overriden by subclass!")
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }
    
    func addChildCoordinators(_ coordinators: [Coordinator]) {
        coordinators.forEach { addChildCoordinator($0) }
    }
    
    @discardableResult func removeChildCoordinator(_ coordinator: Coordinator) -> Bool {
        guard let index = childCoordinators.firstIndex(of: coordinator) else { return false }
        
        childCoordinators.remove(at: index)
        return true
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

extension Coordinator: Equatable {
    
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}

