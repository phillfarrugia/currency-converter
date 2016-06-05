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
    
    private var currencies: [Currency]? {
        didSet {
            currencySelectorView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencySelectorView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    private func requestLatestCurrencyData() {
        NetworkRequestManager.exchangeRatesRequest("AUD", conversionCurrencies: [ "CAD", "EUR", "GBP", "JPY", "USD" ]) { (rates, error) in
            if let error = error {
                // TODO: Present Real Error Message
                print(error)
            }
            
            if let rates = rates {
                self.currencies = rates
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
        // TODO: Do something when a user selects a specific currency
    }

}

