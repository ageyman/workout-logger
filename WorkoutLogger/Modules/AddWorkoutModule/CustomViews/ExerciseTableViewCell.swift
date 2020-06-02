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
    @IBOutlet private weak var setsNumberView: WorkoutTextFieldView!
    @IBOutlet private weak var repsNumberView: WorkoutTextFieldView!
    @IBOutlet private weak var weightNumberView: WorkoutTextFieldView!
    
    func configure(with data: ExerciseValuesModel) {
        setsNumberView.configure(with: WorkoutTextFieldModel(value: data.sets, placeholderText: "sets"))
        repsNumberView.configure(with: WorkoutTextFieldModel(value: data.reps, placeholderText: "reps"))
        weightNumberView.configure(with: WorkoutTextFieldModel(value: data.weight, placeholderText: "kg"))
    }
}
