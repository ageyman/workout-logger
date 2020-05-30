//
//  ExerciseTableViewCell.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 29.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit
import TwoWayBondage

class ExerciseTableViewCell: UITableViewCell, Configurable {
    @IBOutlet weak var setsNumberTextField: UITextField!
    @IBOutlet weak var repsNumberTextField: UITextField!
    @IBOutlet weak var weightValueTextField: UITextField!
    @IBOutlet weak var exerciseNameTextField: WorkoutTextFieldView!
    
    func configure(with data: ExerciseDataModel) {
        exerciseNameTextField.configure(with: WorkoutTextFieldModel(value: data.name))
        setsNumberTextField.text = data.sets
        repsNumberTextField.text = data.reps
        repsNumberTextField.text = data.weight
    }
}

struct ExerciseDataModel {
    let name: Observable<String>
    let sets: String
    let reps: String
    let weight: String
}
