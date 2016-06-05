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
    
    init(baseCurrency: Currency) {
        self.baseCurrency = baseCurrency
    }
    
    func calculateCurrencyRate(baseAmount: Double, outputCurrency: Currency) -> Double {
        let exchangeRate = outputCurrency.exchangeRate
        return baseAmount * exchangeRate
    }
    
}
