//
//  DataSource.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 29.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

protocol DataSource {
    
    var reuseIdentifiers: [String] { get }
    var sectionsNumber: Int { get }
    
    func numberOfCells(in section: Int) -> Int
    func viewConfigurator(at index: Int, in section: Int) -> Configurator
}
