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
    typealias ExerciseSectionViewConfigurator = ViewConfigurator<ExerciseSectionHeaderView>
    
    private var exercisesArray: [ExerciseDataModel]!
    
    func start() {
        let name = Observable("Exercise Name")
        name.bind { value in
            print(value)
        }
        let exercise = ExerciseDataModel(name: name, sets: "1", reps: "0", weight: "0")
        exercisesArray = [exercise]
    }
    
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
    
    var headerFooterReuseIdentifiers: [String] {
        return ["\(ExerciseSectionHeaderView.self)"]
    }
    
    var sectionsNumber: Int {
        return exercisesArray.count
    }
    
    func numberOfCells(in section: Int) -> Int {
        return exercisesArray.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> Configurator {
        let observedValue = Observable("Exercise \(index)")
        observedValue.bind { value in
            print(value)
        }
        
        return ExerciseCellConfigurator(data: ExerciseDataModel(name: observedValue, sets: "Sets", reps: "Reps", weight: "Weight"))
    }
    
    func headerViewConfigurator(in section: Int) -> Configurator? {
        return ExerciseSectionViewConfigurator(data: WorkoutTextFieldModel(value: exercisesArray[section].name))
    }
}
