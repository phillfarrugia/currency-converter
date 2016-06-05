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
     Converts an array of JSON dictionaries into Currency objects. If a conversion
     fails the object if filtered out of the array.
     - parameter dicts:	array of JSON dictionaries
     - returns: array of Currency objects
     */
    static func currenciesWithDictionaries(dicts: [String: AnyObject]) -> [Currency] {
        return dicts.map {
            if let exchangeRate = $0.1 as? Double {
                return Currency(name: $0.0, exchangeRate: exchangeRate)
            }
            return nil
        }.flatMap { $0 }
    }
    
}
