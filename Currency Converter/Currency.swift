//
//  Currency.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

struct Currency {
    
    let name: String
    let exchangeRate: Double?
    
    // MARK: Initializers
    
    init(name: String, exchangeRate: Double? = nil) {
        self.name = name
        self.exchangeRate = exchangeRate
    }
    
    // MARK: Helpers
    
    static func currenciesWithNames(names: [String]) -> [Currency] {
        return names.map {
            return Currency(name: $0)
        }
    }
    
    static func namesWithCurrencies(currencies: [Currency]) -> [String] {
        return currencies.map {
            return $0.name
        }
    }
    
    /**
     Maps a JSON dictionary into a Currency object
     - parameter dict:	JSON dictionary
     - returns: Currency model
     */
    static func currencyWithDictionary(dict: [String: AnyObject]) -> Currency? {
        guard let name = dict.keys.first else { return nil }
        guard let exchangeRate = dict.values.first as? Double else { return nil }
        return Currency(name: name, exchangeRate: exchangeRate)
    }
    
    /**
     Converts an array of JSON dictionaries into Currency objects. If a conversion
     fails the object if filtered out of the array.
     - parameter dicts:	array of JSON dictionaries
     - returns: array of Currency objects
     */
    static func currenciesWithDictionaries(dicts: [[String: AnyObject]]) -> [Currency] {
        return dicts.map {
            if let currency = Currency.currencyWithDictionary($0) {
                return currency
            }
            return nil
        }.flatMap { $0 }
    }
    
}
