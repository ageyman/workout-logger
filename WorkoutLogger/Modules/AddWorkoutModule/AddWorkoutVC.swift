//
//  AddWorkoutVC.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit
import TwoWayBondage

protocol AddWorkoutViewModelProtocol: DataSource, Coordinatable {
    var shouldHideWorkoutDurationView: Observable<Bool> { get }
    var shouldHideWorkoutDateView: Observable<Bool> { get }
    var updateDataIn: Observable<(indexPath: IndexPath, isSection: Bool)> { get }
    var workoutDurationViewModel: WorkoutDurationViewModelProtocol { get }
    var workoutDateViewModel: WorkoutCalendarViewModelProtocol { get }
    
    func deleteWorkoutElement(at indexPath: IndexPath)
    func addNewExercise()
    func saveWorkout()
}

class AddWorkoutVC: BaseVC {
    private var viewModel: AddWorkoutViewModelProtocol! {
        didSet {
            viewModel.start()
        }
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(with: viewModel)
            configureFooterView(for: tableView)
        }
    }
    
    @IBOutlet weak var workoutDurationView: WorkoutDurationView! {
        didSet {
            workoutDurationView.viewModel = viewModel.workoutDurationViewModel
        }
    }
    
    @IBOutlet weak var workoutDateView: WorkoutCalendarView! {
        didSet {
            workoutDateView.viewModel = viewModel.workoutDateViewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        setupBindings(for: viewModel)
        setupButtons(for: navigationItem)
        addGestureForKeyboardDissmissOnTap()
    }
    
    private func setupBindings(for viewModel: AddWorkoutViewModelProtocol) {
        viewModel.updateDataIn.bind { [weak tableView] value in
            if value.isSection {
                tableView?.insertSections(IndexSet(integer: value.indexPath.section), with: .middle)
            } else {
                tableView?.insertRows(at: [value.indexPath], with: .automatic)
            }
        }
        
        viewModel.shouldHideWorkoutDurationView.bindAndFire { [weak workoutDurationView] shouldHide in
            workoutDurationView?.isHidden = shouldHide
        }
        
        viewModel.shouldHideWorkoutDateView.bindAndFire { [weak workoutDateView] shoulHide in
            workoutDateView?.isHidden = shoulHide
        }
    }
    
    private func setupButtons(for navigationItem: UINavigationItem) {
        let durationButton = UIBarButtonItem(image: UIImage(systemName: "clock"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnSetWorkoutDurationButton))
        let dateButton = UIBarButtonItem(image: UIImage(systemName: "calendar"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapOnSetWorkoutDateButton))
        navigationItem.setLeftBarButtonItems([durationButton, dateButton], animated: true)
    }
    
    @objc private func didTapOnSetWorkoutDurationButton() {
        viewModel.shouldHideWorkoutDurationView.value?.toggle()
        viewModel.shouldHideWorkoutDateView.value = true
    }
    
    @objc private func didTapOnSetWorkoutDateButton() {
        viewModel.shouldHideWorkoutDateView.value?.toggle()
        viewModel.shouldHideWorkoutDurationView.value = true
    }
    
    private func configureFooterView(for tableView: UITableView) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        button.addTarget(self, action: #selector(didTapOnAddNewExerciseButton), for: .touchUpInside)
        button.setTitle(" + Add New Exercise", for: .normal)
        button.setTitleColor(.black, for: .normal)
        tableView.tableFooterView = button
    }
    
    @objc private func didTapOnAddNewExerciseButton() {
        viewModel.addNewExercise()
    }
    
    private func addGestureForKeyboardDissmissOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Scene Factory
extension AddWorkoutVC {
    
    static func create() -> UIViewController {
        let viewController = Self.instantiateFromStoryboard()
        let workoutDurationViewModel = WorkoutDurationViewModel()
        let workoutDateViewModel = WorkoutCalendarViewModel()
        viewController.viewModel = AddWorkoutViewModel(workoutDurationViewModel: workoutDurationViewModel,
                                                       workoutDateViewModel: workoutDateViewModel)
        return viewController
    }
}

// MARK: UITableViewDataSource
extension AddWorkoutVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionsNumber
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator =  viewModel.viewConfigurator(at: indexPath.row, in: indexPath.section)
        return tableView.configureCell(for: configurator, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let configuartor = viewModel.headerViewConfigurator(in: section) else { return nil }
        return tableView.configureHeaderFooter(for: configuartor)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let configuartor = viewModel.footerViewConfigurator(in: section) else { return nil }
        return tableView.configureHeaderFooter(for: configuartor)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteWorkoutElement(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: UITableViewDelegate
extension AddWorkoutVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
}

// MARK: KeyboardОbserversHandler
extension AddWorkoutVC: KeyboardОbserversHandler {
    
    func keyboardWillShowAction(notification: NSNotification) {
        if let keyBoardSize = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
            tableView.contentInset.bottom = keyBoardSize.height
            tableView.verticalScrollIndicatorInsets.bottom = 0
        }
    }
    
    func keyboardWillHideAction() {
        tableView.contentInset.bottom = 0
        tableView.verticalScrollIndicatorInsets.bottom = 0
    }
}
