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
    @IBOutlet weak var setsNumberView: WorkoutTextFieldView!
    @IBOutlet weak var repsNumberView: WorkoutTextFieldView!
    @IBOutlet weak var weightNumberView: WorkoutTextFieldView!
    
    func configure(with data: ExerciseValuesModel) {
        setsNumberView.configure(with: WorkoutTextFieldModel(value: data.sets))
        repsNumberView.configure(with: WorkoutTextFieldModel(value: data.reps))
        weightNumberView.configure(with: WorkoutTextFieldModel(value: data.weight))
    }
}
