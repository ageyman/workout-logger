//
//  BaseVC.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
}

// MARK: StoryboardInstantiatable
extension BaseVC: StoryboardInstantiatable {
    static var storyboardName: String {
        return "Main"
    }
}
