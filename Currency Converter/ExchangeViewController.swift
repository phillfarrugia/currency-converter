//
//  ViewController.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController, CurrencySelectorViewDelegate {
    
    @IBOutlet weak private var currencySelectorView: CurrencySelectorView!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak private var baseAmountTextField: UITextField!
    
    static private let baseCurrencyName = "AUD"
    static private let conversionCurrencyNames = [ "CAD", "EUR", "GBP", "JPY", "USD" ]
    
    private var currencies: [Currency]? {
        didSet {
            currencySelectorView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencySelectorView.delegate = self
        
        setupSubViews()
        requestLatestCurrencyData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    private func setupSubViews() {
        
        baseCurrencyLabel.text = ExchangeViewController.baseCurrencyName
        applyDottedUnderlineToView(baseAmountTextField, color: UIColor(red:0.30, green:0.27, blue:0.29, alpha:1.0))
    }
    
    func applyDottedUnderlineToView(view: UIView, color: UIColor) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.CGColor
        borderLayer.fillColor = nil
        borderLayer.lineWidth = 6
        borderLayer.lineDashPattern = [6, 3]
        borderLayer.path = UIBezierPath(rect: CGRectMake(0, view.bounds.height
            , view.bounds.width, 3)).CGPath
        view.layer.addSublayer(borderLayer)
    }
    
    private func requestLatestCurrencyData() {
        NetworkRequestManager.exchangeRatesRequest(ExchangeViewController.baseCurrencyName, conversionCurrencies: ExchangeViewController.conversionCurrencyNames) { (rates, error) in
            if let error = error {
                // TODO: Present Real Error Message
                print(error)
            }
            
            if let rates = rates {
                self.currencies = rates // TODO: Save it to the disk and re-read it on startup
            }
        }
    }
    
    // MARK: CurrencySelectorViewDelegate
    
    func numberOfItems() -> Int {
        guard let currencies = currencies else { return 0 }
        return currencies.count
    }
    
    func textForItemAtIndex(index: Int) -> String? {
        guard let currencies = currencies else { return nil }
        return currencies[index].name
    }
    
    func selectorDidSelectItemAtIndex(index: Int) {
        print("Index Selected: \(index)")
    }

}

