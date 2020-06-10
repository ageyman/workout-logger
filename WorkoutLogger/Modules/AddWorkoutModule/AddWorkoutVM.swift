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
    
    var workoutDurationViewModel: WorkoutDurationViewModelProtocol
    var shouldHideWorkoutDurationView = Observable<Bool>()
    var shouldReloadData = Observable<Bool>(false)
    var reloadDataIn = Observable<(index: Int?, section: Int?)>(nil)
    private var exercisesArray = [ExerciseModel]()
    private var workoutDuration: String?
    
    init(workoutDurationViewModel: WorkoutDurationViewModelProtocol) {
        self.workoutDurationViewModel = workoutDurationViewModel
    }
    
    func start() {
        addNewExercise()
        workoutDurationViewModel.workoutDuration.bind { [weak self] value in
            self?.workoutDuration = value
        }
        
        workoutDurationViewModel
            .shouldHideView
            .bindAndFire { [weak shouldHideWorkoutDurationView] shouldHideView in
                shouldHideWorkoutDurationView?.value = shouldHideView
        }
    }
    
    func saveWorkout() {
        
    }
    
    func setWorkoutDate() {
        
    }
    
    func addNewExercise() {
        let name = Observable("")
        let exerciseValues = configureNewSetValues()
        let exercise = ExerciseModel(name: name, values: [exerciseValues])
        exercisesArray.append(exercise)
        shouldReloadData.value = true
    }
    
    private func addNewSet(in section: Int) {
        let exerciseValues = configureNewSetValues()
        exercisesArray[section].values.append(exerciseValues)
        reloadDataIn.value = (nil, section)
    }
    
    private func configureNewSetValues() -> ExerciseValuesModel {
        let sets = Observable("")
        let reps = Observable("")
        let weight = Observable("")
        return ExerciseValuesModel(sets: sets, reps: reps, weight: weight)
    }
    
    // MARK: DataSource
    var reuseIdentifiers: [String] {
        return [ExerciseCellConfigurator.reuseIdentifier]
    }
    
    var headerFooterReuseIdentifiers: [String] {
        return [ExerciseSectionHeaderViewConfigurator.reuseIdentifier,
                ExerciseSectionFooterViewConfigurator.reuseIdentifier]
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
        return ExerciseSectionHeaderViewConfigurator(data: WorkoutTextFieldModel(value: exercisesArray[section].name, placeholderText: "Exercise Name"))
    }
    
    func footerViewConfigurator(in section: Int) -> Configurator? {
        let addNewSetAction: () -> () = { [weak self] in
            self?.addNewSet(in: section)
        }
        
        return ExerciseSectionFooterViewConfigurator(data: ExerciseSectionFooterModel(action: addNewSetAction))
    }
}
