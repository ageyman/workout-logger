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
    
    func addNewExercise()
    func saveWorkout()
    func setWorkoutDate()
    func setWorkoutDuration()
}

class AddWorkoutVC: BaseVC {
    private var viewModel: AddWorkoutViewModelProtocol! {
        didSet {
            viewModel.start()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(with: viewModel)
        setupBindings(for: viewModel)
    }
    
    private func setupBindings(for viewModel: AddWorkoutViewModelProtocol) {
        viewModel.reloadDataIn.bind { [weak self] value in
            guard let strongSelf = self, let section = value.section else { return }
            
            strongSelf.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
}

// MARK: Scene Factory
extension AddWorkoutVC {
    
    static func create() -> UIViewController {
        let viewController = Self.instantiateFromStoryboard()
        viewController.viewModel = AddWorkoutViewModel()
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
    
}
