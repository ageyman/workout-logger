//
//  CalendarView.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 22.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit
import TwoWayBondage
import KDCalendar

protocol WorkoutCalendarViewModelProtocol {
    var startDate: Date { get }
    var endDate: Date { get }
    var selectedDate: Observable<Date> { get set }
    var shouldHideView: Observable<Bool> { get }
}

class WorkoutCalendarView: BaseView {
    @IBOutlet weak var calendarView: CalendarView!
    
    var viewModel: WorkoutCalendarViewModelProtocol! {
        didSet {
            calendarView.dataSource = self
            calendarView.delegate = self
            calendarView.setDisplayDate(viewModel.selectedDate.value ?? Date())
            calendarView.multipleSelectionEnable = false
        }
    }
}

extension WorkoutCalendarView: CalendarViewDataSource {
    func startDate() -> Date {
        return viewModel.startDate
    }
    
    func endDate() -> Date {
        return viewModel.endDate
    }
    
    func headerString(_ date: Date) -> String? {
        return date.toString(with: "MMMM YYYY")
    }
}

extension WorkoutCalendarView: CalendarViewDelegate {
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        viewModel.selectedDate.value = date
        viewModel.shouldHideView.value = true
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {
        
    }
}
