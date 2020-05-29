//
//  AddWorkoutVC.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 27.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

protocol AddWorkoutViewModelProtocol: DataSource {
    
    func addNewExercise()
    func saveWorkout()
    func setWorkoutDate()
    func setWorkoutDuration()
}

class AddWorkoutVC: BaseVC {
    private var viewModel: AddWorkoutViewModelProtocol!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(with: viewModel)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator =  viewModel.viewConfigurator(at: indexPath.row, in: indexPath.section)
        return tableView.configureCell(for: configurator, at: indexPath)
    }
}

// MARK: UITableViewDelegate
extension AddWorkoutVC: UITableViewDelegate {
    
}
