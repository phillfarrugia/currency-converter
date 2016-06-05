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
    func textForItemAtIndex(index: Int) -> String?
    func selectorDidSelectItemAtIndex(index: Int)
}

class CurrencySelectorView: UIView, UIScrollViewDelegate {
    
    static private let kNumberOfItemsOffscreen: Int = 1
    static private let kCurrencyLabelWidth: CGFloat = 120
    static private let kCurrencyLabelMargin: CGFloat = 10
    
    @IBOutlet weak private var scrollView: UIScrollView?
    
    var delegate: CurrencySelectorViewDelegate?
    
    private var currencyLabels: [CurrencyLabel]?
    private var selectedLabel: CurrencyLabel? {
        didSet {
            if let selectedLabel = selectedLabel, let index = currencyLabels?.indexOf(selectedLabel) {
                delegate?.selectorDidSelectItemAtIndex(index)
            }
        }
    }
    
    var initialSelectionIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        
        if let scrollView = scrollView {
            scrollView.delegate = self
        }
    }
    
    func reloadData() {
        // TODO: Some stuff
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
        scrollView.contentInset = UIEdgeInsetsMake(0, self.center.x - CurrencySelectorView.kCurrencyLabelWidth/2, 0, self.center.x - CurrencySelectorView.kCurrencyLabelWidth/2)
        
        // Map new items into Currency Labels
        self.currencyLabels = itemIndexes.map {
            if let currencyText = delegate.textForItemAtIndex($0) {
                return currencyLabelForIndex($0, text: currencyText)
            }
            return nil
        }.flatMap { $0 }
        
        // Add new Currency Labels as subviews
        if let currencyLabels = self.currencyLabels {
            for currencyLabel in currencyLabels {
                scrollView.addSubview(currencyLabel)
            }
        }
        
        // Check if Intitial Index is inside array bounds
        if (initialSelectionIndex >= 0 && initialSelectionIndex < numberOfItems) {
            scrollToItemAtIndex(initialSelectionIndex, animated: false)
        } else {
            scrollToItemAtIndex(0, animated: false)
        }
    }
    
    private func currencyLabelForIndex(index: Int, text: String) -> CurrencyLabel {
        let xOffset = ((CGFloat(index) * CurrencySelectorView.kCurrencyLabelWidth) + (CGFloat(index) * CurrencySelectorView.kCurrencyLabelMargin))
        let frame = CGRectMake(xOffset, 0, CurrencySelectorView.kCurrencyLabelWidth, self.bounds.height)
        let label = CurrencyLabel(frame: frame)
        label.text = text
        return label
    }
    
    private func scrollToItemAtIndex(index: Int, animated: Bool) {
        guard let scrollView = scrollView else { return }
        guard let currencyLabels = currencyLabels else { return }
        
        // Deselect Current Selection
        if let selectedLabel = selectedLabel {
            selectedLabel.setSelected(false)
        }
        
        // New Selection Label at Index
        let newSelection = currencyLabels[index]
        newSelection.setSelected(true)
        self.selectedLabel = newSelection
        
        // Scroll to Currency Label center x
        let xOffset = newSelection.center.x - self.center.x
        let scrollViewContentOffset = CGPoint(x: xOffset, y: 0)
        scrollView.setContentOffset(scrollViewContentOffset, animated: animated)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let currencyLabels = currencyLabels else { return }
        guard let selectedLabel = selectedLabel else { return }
        
        let labelWidth = CurrencySelectorView.kCurrencyLabelWidth + CurrencySelectorView.kCurrencyLabelMargin
        let targetItemIndex = Int(floor((scrollView.contentOffset.x + self.center.x) / labelWidth))
        if (targetItemIndex >= 0 && targetItemIndex < currencyLabels.count) {
            let targetItem = currencyLabels[targetItemIndex]
            selectedLabel.setSelected(false)
            targetItem.setSelected(true)
            self.selectedLabel = targetItem
        }
    }
    
}
