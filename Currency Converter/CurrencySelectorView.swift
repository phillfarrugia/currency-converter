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
    
    @IBOutlet weak private var scrollView: UIScrollView?
    
    var delegate: CurrencySelectorViewDelegate?
    
    private var currencyLabels: [UIView]?
    
    var initialSelectionIndex: Int = 0 {
        didSet {
            scrollToSelectedIndex(initialSelectionIndex)
        }
    }
    
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
        guard let scrollView = scrollView else { return }
        let numberOfItems = delegate.numberOfItems()
        let itemIndexes = 0..<numberOfItems
        
        // Calculate Scroll View Content Width & Content Inset
        let labelsWidth = (CGFloat(numberOfItems) * CurrencySelectorView.kCurrencyLabelWidth) + (CGFloat(numberOfItems) * CurrencySelectorView.kCurrencyLabelMargin)
        scrollView.contentSize.width = labelsWidth
        scrollView.contentInset = UIEdgeInsetsMake(0, CurrencySelectorView.kCurrencyLabelWidth, 0, CurrencySelectorView.kCurrencyLabelWidth)
        
        // Map new items into Currency Labels
        self.currencyLabels = itemIndexes.map {
            return currencyLabelForIndex($0, text: delegate.textForItemAtIndex($0))
        }
        
        // Add new Currency Labels as subviews
        if let currencyLabels = self.currencyLabels {
            for currencyLabel in currencyLabels {
                scrollView.addSubview(currencyLabel)
            }
        }
        
        scrollToSelectedIndex(0)
    }
    
    private func currencyLabelForIndex(index: Int, text: String) -> CurrencyLabel {
        let xOffset = ((CGFloat(index) * CurrencySelectorView.kCurrencyLabelWidth) + (CGFloat(index) * CurrencySelectorView.kCurrencyLabelMargin))
        let frame = CGRectMake(xOffset, 0, CurrencySelectorView.kCurrencyLabelWidth, self.bounds.height)
        let label = CurrencyLabel(frame: frame)
        label.text = text
        return label
    }
    
    private func scrollToSelectedIndex(selectedIndex: Int) {
        guard let scrollView = scrollView else { return }
        guard let currencyLabels = currencyLabels else { return }
        let selectedLabel = currencyLabels[selectedIndex]
        let xOffset = selectedLabel.center.x - self.center.x
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }

}
