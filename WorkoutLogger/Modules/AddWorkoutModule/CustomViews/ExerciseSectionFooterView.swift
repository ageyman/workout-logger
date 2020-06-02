//
//  ExerciseSectionFooterView.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 1.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//
import UIKit

class ExerciseSectionFooterView: UITableViewHeaderFooterView, Configurable {
    private var data: ExerciseSectionFooterModel!
    
    func configure(with data: ExerciseSectionFooterModel) {
        self.data = data
    }
    
    @IBAction private func didTapOnAddNewSetButton(_ sender: Any) {
        data.action()
    }
}

struct ExerciseSectionFooterModel {
    let action: () -> ()
}
