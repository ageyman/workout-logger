//
//  ExerciseSectionFooterView.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 1.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//
import UIKit

class ExerciseSectionFooterView: UITableViewHeaderFooterView, Configurable {
    var data: ExerciseSectionFooterViewModel!
    
    func configure(with data: ExerciseSectionFooterViewModel) {
        self.data = data
    }
    
    @IBAction func didTapOnAddNewSetButton(_ sender: Any) {
        data.action()
    }
}

struct ExerciseSectionFooterViewModel {
    let action: () -> ()
}
