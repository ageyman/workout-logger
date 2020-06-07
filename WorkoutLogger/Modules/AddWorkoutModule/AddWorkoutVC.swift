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
    var reloadDataIn: Observable<(index: Int?, section: Int?)> { get }
    var shouldReloadData: Observable<Bool> { get }
    var workoutDurationViewModel: WorkoutDurationViewModelProtocol { get }
    
    func configureFooterView(for tableView: UITableView)
    func saveWorkout()
    func setWorkoutDate()
    func setWorkoutDuration()
}

class AddWorkoutVC: BaseVC {
    private var viewModel: AddWorkoutViewModelProtocol! {
        didSet {
            viewModel.start()
            setupBindings(for: viewModel)
        }
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(with: viewModel)
            viewModel.configureFooterView(for: tableView)
        }
    }
    
    @IBOutlet weak var workoutDurationView: WorkoutDurationView! {
        didSet {
            workoutDurationView.viewModel = viewModel.workoutDurationViewModel
            workoutDurationView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
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
        workoutDurationView.isHidden = workoutDurationView.isHidden ? false : true
    }
}

// MARK: Scene Factory
extension AddWorkoutVC {
    
    static func create() -> UIViewController {
        let viewController = Self.instantiateFromStoryboard()
        viewController.viewModel = AddWorkoutViewModel(workoutDurationViewModel: WorkoutDurationViewModel())
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
