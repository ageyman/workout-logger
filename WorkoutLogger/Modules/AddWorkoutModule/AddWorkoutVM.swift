//
//  AddWorkoutVM.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import Foundation

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
        return 5
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> Configurator {
        return ExerciseCellConfigurator(data: ExerciseDataModel(name: "Name", sets: "Sets", reps: "Reps", weight: "Weight"))
    }
}
