//
//  CurrencyLabel.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import UIKit

@IBDesignable class CurrencyLabel: UILabel {
    
    static private let kCurrencyLabelDeselectedColor = UIColor(red:0.26, green:0.87, blue:0.55, alpha:1.0)
    static private let kCurrencyLabelSelectedColor = UIColor.whiteColor()
    
    // MARK: Initializers
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureStyle()
    }
    
    override func prepareForInterfaceBuilder() {
        configureStyle()
    }
    
    // MARK: Styles
    
    private func configureStyle() {
        textColor = CurrencyLabel.kCurrencyLabelDeselectedColor
        backgroundColor = .clearColor()
        font = UIFont(name: "HelveticaNeue-Medium", size: 56)
        textAlignment = .Center
    }

}
