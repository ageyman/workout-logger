//
//  BaseView.swift
//  WorkoutLogger
//
//  Created by Aleksandar Geyman on 30.05.20.
//  Copyright © 2020 Aleksandar Geyman. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    private func setupView() {
        guard let view = loadViewFromNib() else { return }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView? {
        let objectType = type(of: self)
        let bundle = Bundle(for: objectType)
        let nib = UINib(nibName: "\(objectType)", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
