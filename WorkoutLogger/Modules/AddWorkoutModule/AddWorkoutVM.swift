//
//  AddWorkoutVM.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import Foundation
import TwoWayBondage

class AddWorkoutViewModel: AddWorkoutViewModelProtocol {
    typealias ExerciseCellConfigurator = ViewConfigurator<ExerciseTableViewCell>
    
    func addNewExercise() {
        
    }
    
    func saveWorkout() {
        
    }
    
    func setWorkoutDate() {
        
    }
    
    func setWorkoutDuration() {
        
    }
    
    // MARK: DataSource
    var reuseIdentifiers: [String] {
        return ["\(ExerciseTableViewCell.self)"]
    }
    
    var sectionsNumber: Int {
        return 1
    }
    
    func numberOfCells(in section: Int) -> Int {
        return 50
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> Configurator {
        let observedValue = Observable("Exercise \(index)")
        observedValue.bind { value in
            print(value)
        }
        
        return ExerciseCellConfigurator(data: ExerciseDataModel(name: observedValue, sets: "Sets", reps: "Reps", weight: "Weight"))
    }
}
