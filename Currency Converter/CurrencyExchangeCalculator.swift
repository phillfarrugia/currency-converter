//
//  CurrencyExchangeCalculator.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

class CurrencyExchangeCalculator {
    
    let baseCurrency: Currency
    
    // MARK: Initializers
    
    init(baseCurrency: Currency) {
        self.baseCurrency = baseCurrency
    }
    
    // MARK: Calculation
    
    /**
     Performs a currency exchange from the base currency into the provided
     output currency.
     - parameter baseAmount: amount value to convert from base currency
     - parameter outputCurrency: output currency object to convert to
     - returns: converted currency value in output currency exchange rate
     */
    func calculateCurrencyRate(baseAmount: Double, outputCurrency: Currency) -> Double {
        let exchangeRate = outputCurrency.exchangeRate
        return baseAmount * exchangeRate
    }
    
}
