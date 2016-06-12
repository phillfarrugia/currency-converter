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
    
    /**
     Formats an exchanged currency ouput into a locale friendly string with the
     appropriate locale currency symbol.
     - parameter rate: converted amount
     - parameter currency: currency converted to
     - returns: a string containing the amount and locale currency symbol
     */
    static func formattedCurrencyRate(rate: Double, currency: Currency) -> String {
        let locale = NSLocale(localeIdentifier: currency.code)
        if let localeCurrencySymbol = locale.displayNameForKey(NSLocaleCurrencySymbol, value: currency.code) {
            return String(format: "\(localeCurrencySymbol) %.2f", rate)
        }
        return "\(rate)"
    }
    
}
