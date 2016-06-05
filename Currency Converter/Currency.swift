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
    let exchangeRate: Double
    
    init(name: String, exchangeRate: Double) {
        self.name = name
        self.exchangeRate = exchangeRate
    }
    
}
