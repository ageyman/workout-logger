//
//  ExerciseTableViewCell.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 29.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell, Configurable {
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var setsNumberTextField: UITextField!
    @IBOutlet weak var repsNumberTextField: UITextField!
    @IBOutlet weak var weightValueTextField: UITextField!
    
    func configure(with data: ExerciseDataModel) {
        exerciseTextField.text = data.name
        setsNumberTextField.text = data.sets
        repsNumberTextField.text = data.reps
        repsNumberTextField.text = data.weight
    }
}

struct ExerciseDataModel {
    let name: String
    let sets: String
    let reps: String
    let weight: String
}
