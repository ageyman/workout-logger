//
//  WorkoutDurationViewModel.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 7.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import Foundation
import TwoWayBondage

private enum WorkoutDurationType: String, CaseIterable {
    case veryShort = "15 min"
    case short = "30 min"
    case medium = "1 hour"
    case long = "2 hours"
    case veryLong = "3 hours"
}

class WorkoutDurationViewModel: WorkoutDurationViewModelProtocol {
    typealias WorkoutDurationConfigurator = ViewConfigurator<WorkoutDurationTableViewCell>
    
    var workoutDuration = Observable<String>()
    var shouldHideView = Observable<Bool>(true)
    private var availableOptions: [WorkoutDurationType]!
    
    // MARK: Coordinatable
    func start() {
        availableOptions = WorkoutDurationType.allCases
    }
    
    // MARK: DataSource
    var reuseIdentifiers: [String] {
        return [WorkoutDurationConfigurator.reuseIdentifier]
    }
    
    var sectionsNumber: Int {
        return 1
    }
    
    func numberOfCells(in section: Int) -> Int {
        availableOptions.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> Configurator {
        let configurator = WorkoutDurationConfigurator(data: availableOptions[index].rawValue)
        configurator.actionOnTap = { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.workoutDuration.value = strongSelf.availableOptions[index].rawValue
            strongSelf.shouldHideView.value = true
        }
        
        return configurator
    }
}
