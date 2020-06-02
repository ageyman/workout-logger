//
//  WorkoutTextFieldView.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 30.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit
import TwoWayBondage

class WorkoutTextFieldView: BaseView, Configurable {
    
    @IBOutlet private weak var valueTextField: UITextField!
    private var data: WorkoutTextFieldModel!
    
    func configure(with data: WorkoutTextFieldModel) {
        self.data = data
        valueTextField.text = data.value.value
        valueTextField.addTarget(self, action: #selector(textFieldDidChangeValue(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChangeValue(_ textField: UITextField) {
        data.value.value = textField.text
    }
}

class WorkoutTextFieldModel {
    let value: Observable<String>
    
    init(value: Observable<String>) {
        self.value = value
    }
}
