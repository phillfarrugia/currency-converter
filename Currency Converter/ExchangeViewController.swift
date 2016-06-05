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
    
    private let currencies = [ "CAD", "EUR", "GBP", "JPY", "USD" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencySelectorView.delegate = self
        
        let baseCurrency = Currency(name: "AUD")
        let conversionCurrencies = Currency.currenciesWithNames([ "CAD", "EUR", "GBP", "JPY", "USD" ])
        NetworkRequestManager.exchangeRatesRequest(baseCurrency, conversionCurrencies: conversionCurrencies) {
            //
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: CurrencySelectorViewDelegate
    
    func numberOfItems() -> Int {
        return currencies.count
    }
    
    func textForItemAtIndex(index: Int) -> String {
        return currencies[index]
    }
    
    func selectorDidSelectItemAtIndex(index: Int) {
        // TODO: Do something when a user selects a specific currency
        let selectedCurrency = currencies[index]
    }

}

