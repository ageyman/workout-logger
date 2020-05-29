//
//  Configurator.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 29.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

protocol Configurable {
    associatedtype DataType
    
    func configure(with data: DataType)
}

protocol Configurator {
    var reuseIdentifier: String { get }
    var actionOnTap: (() -> Void)? { get set }
    
    func configure(_ view: UIView)
}

class ViewConfigurator<T: Configurable>: Configurator {
    var reuseIdentifier: String {
        return "\(T.self)"
    }
    
    var actionOnTap: (() -> Void)?
    var data: T.DataType
    
    init(data: T.DataType, actionOnTap: (() -> Void)? = nil) {
        self.data = data
        self.actionOnTap = actionOnTap
    }
    
    func configure(_ view: UIView) {
        guard let configurableView = view as? T else { return }
        
        configurableView.configure(with: data)
    }
}

extension UITableView {
    
    func register(cellNames: String...) {
        for cellName in cellNames {
            register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        }
    }
    
    func register(cellNames: [String]) {
        cellNames.forEach {register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)}
    }
    
    func register(with dataSource: DataSource){
        register(cellNames: dataSource.reuseIdentifiers)
    }
    
    func configureCell(for configurator: Configurator, at indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: configurator.reuseIdentifier, for: indexPath)
        configurator.configure(cell)
        return cell
    }
}
