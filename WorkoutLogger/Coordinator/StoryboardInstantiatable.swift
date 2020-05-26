//
//  StoryboardInstantiatable.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 26.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable where Self: UIViewController {
    static var storyboardName: String { get }
    
    static func instantiateFromStoryboard(withName storyboardName: String) -> Self
}

extension StoryboardInstantiatable {
    
    static func instantiateFromStoryboard(withName storyboardName: String = storyboardName) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(identifier: "\(self)")
    }
}
