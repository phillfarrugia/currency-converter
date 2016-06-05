//
//  HorizontalLabelSelectorView.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import UIKit

protocol CurrencySelectorViewDelegate {
    
    func numberOfItems() -> Int
    func textForItemAtIndex(index: Int) -> String
    func selectorDidSelectItemAtIndex(index: Int)
    
}

class CurrencySelectorView: UIView {
    
    var delegate: CurrencySelectorViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
    }

}
