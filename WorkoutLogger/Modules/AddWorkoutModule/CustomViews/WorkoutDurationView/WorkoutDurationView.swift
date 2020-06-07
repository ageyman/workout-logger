//
//  WorkoutDurationView.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 7.06.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

protocol WorkoutDurationViewModelProtocol: DataSource, Coordinatable {
    
}

class WorkoutDurationView: BaseView {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: WorkoutDurationViewModelProtocol! {
        didSet {
            viewModel.start()
            tableView.register(with: viewModel)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
}

extension WorkoutDurationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCells(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = viewModel.viewConfigurator(at: indexPath.row, in: indexPath.section)
        return tableView.configureCell(for: configurator, at: indexPath)
    }
}

extension WorkoutDurationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.viewConfigurator(at: indexPath.row, in: indexPath.section).actionOnTap?()
    }
}
