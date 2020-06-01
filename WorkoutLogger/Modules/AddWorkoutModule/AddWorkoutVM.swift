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
    typealias ExerciseSectionHeaderViewConfigurator = ViewConfigurator<ExerciseSectionHeaderView>
    typealias ExerciseSectionFooterViewConfigurator = ViewConfigurator<ExerciseSectionFooterView>
    
    var reloadDataIn = Observable<(index: Int?, section: Int?)>(nil)
    private var exercisesArray: [ExerciseModel]!
    
    func start() {
        let name = Observable("")
        let sets = Observable("")
        let reps = Observable("")
        let weight = Observable("")
        let exerciseValues = ExerciseValuesModel(sets: sets, reps: reps, weight: weight)
        let exercise = ExerciseModel(name: name, values: [exerciseValues])
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
    
    private func addNewSet(in section: Int) {
        let sets = Observable("")
        let reps = Observable("")
        let weight = Observable("")
        let exerciseValues = ExerciseValuesModel(sets: sets, reps: reps, weight: weight)
        exercisesArray[section].values.append(exerciseValues)
        reloadDataIn.value = (nil, section)
    }
    
    // MARK: DataSource
    var reuseIdentifiers: [String] {
        return ["\(ExerciseTableViewCell.self)"]
    }
    
    var headerFooterReuseIdentifiers: [String] {
        return ["\(ExerciseSectionHeaderView.self)",
            "\(ExerciseSectionFooterView.self)"]
    }
    
    var sectionsNumber: Int {
        return exercisesArray.count
    }
    
    func numberOfCells(in section: Int) -> Int {
        return exercisesArray[section].values.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> Configurator {
        return ExerciseCellConfigurator(data: exercisesArray[section].values[index])
    }
    
    func headerViewConfigurator(in section: Int) -> Configurator? {
        return ExerciseSectionHeaderViewConfigurator(data: WorkoutTextFieldModel(value: exercisesArray[section].name))
    }
    
    func footerViewConfigurator(in section: Int) -> Configurator? {
        let addNewSetAction: () -> () = { [weak self] in
            self?.addNewSet(in: section)
        }
        
        return ExerciseSectionFooterViewConfigurator(data: ExerciseSectionFooterViewModel(action: addNewSetAction))
    }
}
