//
//  Date+ToStringWithFormat.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 22.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import Foundation

extension Date {
    func toString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
