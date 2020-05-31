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
    var headerFooterReuseIdentifiers: [String] { get }
    var sectionsNumber: Int { get }
    
    func numberOfCells(in section: Int) -> Int
    func viewConfigurator(at index: Int, in section: Int) -> Configurator
    func headerViewConfigurator(in section: Int) -> Configurator?
    func footerViewConfigurator(in section: Int) -> Configurator?
}

extension DataSource {
    var headerFooterReuseIdentifiers: [String] {
        return []
    }
    
    func headerViewConfigurator(in section: Int) -> Configurator? {
        return nil
    }
    
    func footerViewConfigurator(in section: Int) -> Configurator? {
        return nil
    }
}
