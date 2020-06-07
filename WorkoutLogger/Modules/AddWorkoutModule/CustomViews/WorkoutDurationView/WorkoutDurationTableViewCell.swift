//
//  WorkoutDurationTableViewCell.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 7.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class WorkoutDurationTableViewCell: UITableViewCell, Configurable {
    @IBOutlet weak var workoutDurationLabel: UILabel!
    
    func configure(with data: String) {
        workoutDurationLabel.text = data
    }
}
