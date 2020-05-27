//
//  TabItemTypeEnum.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import Foundation

enum TabItemType: Int {
    case workout = 0
    case exercises
    case history
    
    var title: String {
        let title: String
        switch self {
        case .workout:
            title = "Add Workout"
        case .exercises:
            title = "Exercises"
        case .history:
            title = "History"
        }
        
        return title
    }
    
    var index: Int {
        return rawValue
    }
}
