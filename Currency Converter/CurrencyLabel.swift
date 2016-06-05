//
//  CurrencyLabel.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import UIKit

@IBDesignable class CurrencyLabel: UILabel {
    
    static let kCurrencyLabelDeselectedColor = UIColor(red:0.26, green:0.87, blue:0.55, alpha:1.0)
    static let kCurrencyLabelSelectedColor = UIColor.whiteColor()
    
    private var isSelected: Bool = false
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureStyle()
    }
    
    // MARK: Styles
    
    private func configureStyle() {
        textColor = CurrencyLabel.kCurrencyLabelDeselectedColor
        backgroundColor = .clearColor()
        font = UIFont(name: "HelveticaNeue-Medium", size: 56)
        textAlignment = .Center
    }
    
    func setSelected(selected: Bool) {
        if (selected) {
            isSelected = true
            textColor = CurrencyLabel.kCurrencyLabelSelectedColor
        }
        else {
            isSelected = false
            textColor = CurrencyLabel.kCurrencyLabelDeselectedColor
        }
    }

}
