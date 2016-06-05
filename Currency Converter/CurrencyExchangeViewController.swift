//
//  ViewController.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import UIKit

class CurrencyExchangeViewController: UIViewController, CurrencySelectorViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak private var currencySelectorView: CurrencySelectorView!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak var outputCurrencyLabel: UILabel!
    @IBOutlet weak private var baseAmountTextField: DynamicWidthTextField!
    
    static private let baseCurrencyName = "AUD"
    static private let conversionCurrencyNames = [ "CAD", "EUR", "GBP", "JPY", "USD" ]
    static private let kMaximumDigits = 14
    
    let exchangeCalculator = CurrencyExchangeCalculator(baseCurrency: Currency(name: baseCurrencyName))
    
    private var selectedCurrencyIndex: Int = 2
    
    private var currencies: [Currency]? {
        didSet {
            currencySelectorView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencySelectorView.delegate = self
        
        setupSubViews()
        requestLatestCurrencyData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calculateExchangeAmount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    private func setupSubViews() {
        baseCurrencyLabel.text = CurrencyExchangeViewController.baseCurrencyName
        baseAmountTextField.text = "0.00"
        baseAmountTextField.delegate = self
        baseAmountTextField.addTarget(self, action: #selector(CurrencyExchangeViewController.textFieldTextDidChange(_:)), forControlEvents: .EditingChanged)
        
        // Resign Keyboard on tap outside Text Field
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CurrencyExchangeViewController.didTapOutsideTextField))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        currencySelectorView.initialSelectionIndex = selectedCurrencyIndex
    }
    
    private func requestLatestCurrencyData() {
        NetworkRequestManager.exchangeRatesRequest(CurrencyExchangeViewController.baseCurrencyName, conversionCurrencies: CurrencyExchangeViewController.conversionCurrencyNames) { (rates, error) in
            if let error = error {
                // TODO: Present Real Error Message
                print(error)
            }
            
            if let rates = rates {
                self.currencies = rates // TODO: Save it to the disk and re-read it on startup
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
        selectedCurrencyIndex = index
        calculateExchangeAmount()
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let textFieldText = textField.text {
            let proposedText = (textFieldText as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            // Number of digits is greather than maximum
            if (proposedText.characters.count > CurrencyExchangeViewController.kMaximumDigits) {
                return false
            }
            
            if ((proposedText as NSString).rangeOfString(".").location != NSNotFound) {
                // Restrict number of decimal places (".") characters to 1
                if (proposedText.componentsSeparatedByString(".").count > 2) {
                    return false
                }
                else if (proposedText.componentsSeparatedByString(".")[1].characters.count > 2) {
                    // Restrict number of digits after decimal to 2
                    return false
                }
            }
            
            // Filter out invalid characters
            return !containsInvalidCharacters(proposedText)
        }
        return !containsInvalidCharacters(string)
    }
    
    internal func textFieldTextDidChange(textField: UITextField) {
        calculateExchangeAmount()
        UIView.animateWithDuration(0.1) {
            textField.invalidateIntrinsicContentSize()
        }
    }
    
    private func containsInvalidCharacters(text: String) -> Bool {
        let range = (text as NSString).rangeOfCharacterFromSet(NSCharacterSet.letterCharacterSet())
        if (range.location != NSNotFound) {
            return true
        }
        else {
            return false
        }
    }
    
    // MARK: UIGestureRecognizer
    
    internal func didTapOutsideTextField() {
        baseAmountTextField.resignFirstResponder()
    }
    
    // MARK: Calculation
    
    private func calculateExchangeAmount() {
        if let textFieldText = baseAmountTextField.text {
            guard let currencies = currencies else { return }
            let selectedCurrency = currencies[selectedCurrencyIndex]
            let outputCurrencyAmount = exchangeCalculator.calculateCurrencyRate((textFieldText as NSString).doubleValue, outputCurrency: selectedCurrency)
            outputCurrencyLabel.text = "\(outputCurrencyAmount)"
        }
        else {
            outputCurrencyLabel.text = "0.00"
        }
    }

}

