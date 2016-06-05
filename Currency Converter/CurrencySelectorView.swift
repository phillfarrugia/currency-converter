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
    
    static private let kNumberOfItemsOffscreen: Int = 1
    static private let kCurrencyLabelWidth: CGFloat = 120
    static private let kCurrencyLabelMargin: CGFloat = 10
    
    var delegate: CurrencySelectorViewDelegate?
    
    private var currencyLabels: [UIView]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Remove existing Currency Labels
        if let currencyLabels = self.currencyLabels {
            for currencyLabel in currencyLabels {
                currencyLabel.removeFromSuperview()
            }
        }
        
        guard let delegate = delegate else { return }
        let numberOfItems = delegate.numberOfItems()
        let itemIndexes = 0..<numberOfItems
        
        // Calculate the x-origin point, so that new labels are centered horizontally
        let labelsWidth = (CGFloat(numberOfItems) * CurrencySelectorView.kCurrencyLabelWidth) + (CGFloat(numberOfItems) * CurrencySelectorView.kCurrencyLabelMargin)
        let xOrigin = center.x - labelsWidth/2
        
        // Map new items into Currency Labels
        self.currencyLabels = itemIndexes.map {
            return currencyLabelForIndex($0, text: delegate.textForItemAtIndex($0), xOrigin: xOrigin)
        }
        
        // Add new Currency Labels as subviews
        if let currencyLabels = self.currencyLabels {
            for currencyLabel in currencyLabels {
                addSubview(currencyLabel)
            }
        }
    }
    
    private func currencyLabelForIndex(index: Int, text: String, xOrigin: CGFloat) -> CurrencyLabel {
        let xOffset = xOrigin + ((CGFloat(index) * CurrencySelectorView.kCurrencyLabelWidth) + (CGFloat(index) * CurrencySelectorView.kCurrencyLabelMargin))
        let frame = CGRectMake(xOffset, 0, CurrencySelectorView.kCurrencyLabelWidth, self.bounds.height)
        let label = CurrencyLabel(frame: frame)
        label.text = text
        return label
    }

}
