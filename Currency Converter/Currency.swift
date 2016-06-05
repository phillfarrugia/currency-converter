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
    
    init(name: String, exchangeRate: Double? = nil) {
        self.name = name
        self.exchangeRate = exchangeRate
    }
    
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
    
}
