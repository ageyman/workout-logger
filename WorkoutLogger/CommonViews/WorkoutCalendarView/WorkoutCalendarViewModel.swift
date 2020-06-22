//
//  CalendarViewVM.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 22.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import Foundation
import TwoWayBondage

private struct WorkoutCalendarConstants {
    static var startDate: Date {
        var dateComponents = DateComponents()
        dateComponents.year = -1
        return Calendar.current.date(byAdding: dateComponents, to: Date()) ?? Date()
    }
    
    static var endDate: Date {
        var dateComponents = DateComponents()
        dateComponents.year = 1
        return Calendar.current.date(byAdding: dateComponents, to: Date()) ?? Date()
    }
}

class WorkoutCalendarViewModel: WorkoutCalendarViewModelProtocol {
    var startDate = WorkoutCalendarConstants.startDate
    var endDate = WorkoutCalendarConstants.endDate
    var selectedDate = Observable<Date>(Date())
    var shouldHideView = Observable<Bool>(true)
}
