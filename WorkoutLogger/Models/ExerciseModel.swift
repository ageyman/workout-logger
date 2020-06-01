//
//  File.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 1.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import Foundation
import TwoWayBondage

struct ExerciseModel {
    let name: Observable<String>
    var values: [ExerciseValuesModel]
}

struct ExerciseValuesModel {
    let sets: Observable<String>
    let reps: Observable<String>
    let weight: Observable<String>
}
