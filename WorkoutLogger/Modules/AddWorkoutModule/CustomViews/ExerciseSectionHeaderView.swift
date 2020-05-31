//
//  ExerciseSectionHeaderView.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 31.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class ExerciseSectionHeaderView: UITableViewHeaderFooterView, Configurable {
    
    @IBOutlet weak var exerciseNameView: WorkoutTextFieldView!
    func configure(with data: WorkoutTextFieldModel) {
        exerciseNameView.configure(with: data)
    }
}
