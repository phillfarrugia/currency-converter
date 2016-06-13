//
//  Currency_ConverterTests.swift
//  Currency ConverterTests
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import XCTest
@testable import Currency_Converter

class CurrencyExchangeCalculatorTests: XCTestCase {
    
    let baseCurrency = Currency(code: "AUD", exchangeRate: 1.5274)
    let outputCurrency = Currency(code: "GBP", exchangeRate: 0.7848)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCalculateCurrencyRate() {
        let exchangeCalculator = CurrencyExchangeCalculator(baseCurrency: baseCurrency)
        let output = exchangeCalculator.calculateCurrencyRate(1.0, outputCurrency: outputCurrency)
        
        XCTAssertEqual(output, 0.7848)
    }
    
    func testFormattedCurrencyRate() {
        
        let unformattedRate = 0.7848
        let formattedOutputString = CurrencyExchangeCalculator.formattedCurrencyRate(unformattedRate, currency: outputCurrency)
        
        XCTAssertEqual(formattedOutputString, "£ 0.78")
    }
    
}
