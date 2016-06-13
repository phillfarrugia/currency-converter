//
//  Currency_ConverterUITests.swift
//  Currency ConverterUITests
//
//  Created by Phill Farrugia on 12/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import XCTest

class Currency_ConverterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExchangeViewController() {
        
        let app = XCUIApplication()
        
        // UITextField Tap to become First Responder
        let baseCurrencyTextFieldContainer = app.otherElements.containingType(.Image, identifier:"Logo").childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).elementBoundByIndex(0)
        let baseCurrencyTextField = baseCurrencyTextFieldContainer.childrenMatchingType(.Other).element
        baseCurrencyTextField.childrenMatchingType(.TextField).element.tap()
        
        // Tap Backspace 4 times to remove '$0.00'
        let deleteKey = app.keys["Delete"]
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        
        // Type "6344.63" into UITextField
        baseCurrencyTextField.childrenMatchingType(.TextField).element
        
        let sixKey = app.keys["6"]
        let threeKey = app.keys["3"]
        let fourKey = app.keys["4"]
        let dotKey = app.keys["."]
        
        sixKey.tap()
        threeKey.tap()
        fourKey.tap()
        fourKey.tap()
        dotKey.tap()
        sixKey.tap()
        threeKey.tap()
        
        // Tap outside TextField to dismiss Keyboard
        baseCurrencyTextFieldContainer.tap()
        
        // Find value in Output UILabel
        let outputCurrencyLabel = app.staticTexts.elementBoundByIndex(7).label
        
        // Assertion
        XCTAssert(outputCurrencyLabel.characters.count > 0, "Expected currency label value")
    }
    
}
