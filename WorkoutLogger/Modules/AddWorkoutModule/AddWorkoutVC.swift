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
    var reloadDataIn: Observable<(index: Int?, section: Int?)> { get }
    var shouldReloadData: Observable<Bool> { get }
    var workoutDurationViewModel: WorkoutDurationViewModelProtocol { get }
    
    func addNewExercise()
    func saveWorkout()
    func setWorkoutDate()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        setupBindings(for: viewModel)
        setupButtons(for: navigationItem)
    }
    
    private func setupBindings(for viewModel: AddWorkoutViewModelProtocol) {
        viewModel.reloadDataIn.bind { [weak self] value in
            guard let strongSelf = self, let section = value.section else { return }
            
            strongSelf.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
        
        viewModel.shouldReloadData.bind { [weak self] shouldReload in
            if shouldReload {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.shouldHideWorkoutDurationView.bindAndFire { [weak workoutDurationView] shouldHide in
            workoutDurationView?.isHidden = shouldHide
        }
    }
    
    private func setupButtons(for navigationItem: UINavigationItem) {
        let durationButton = UIBarButtonItem(image: UIImage(systemName: "clock"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnSetWorkoutDurationButton))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        navigationItem.setLeftBarButtonItems([spacer, spacer, durationButton], animated: true)
    }
    
    @objc private func didTapOnSetWorkoutDurationButton() {
        viewModel.shouldHideWorkoutDurationView.value?.toggle()
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
}

// MARK: Scene Factory
extension AddWorkoutVC {
    
    static func create() -> UIViewController {
        let viewController = Self.instantiateFromStoryboard()
        let viewModel = WorkoutDurationViewModel()
        viewController.viewModel = AddWorkoutViewModel(workoutDurationViewModel: viewModel)
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
