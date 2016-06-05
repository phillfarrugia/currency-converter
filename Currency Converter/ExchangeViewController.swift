//
//  ViewController.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController, CurrencySelectorViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak private var currencySelectorView: CurrencySelectorView!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak private var baseAmountTextField: DynamicWidthTextField!
    
    static private let baseCurrencyName = "AUD"
    static private let conversionCurrencyNames = [ "CAD", "EUR", "GBP", "JPY", "USD" ]
    
    static private let defaultTextFieldAttributes: [String: AnyObject] = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: 44)!
    ]
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    private func setupSubViews() {
        baseCurrencyLabel.text = ExchangeViewController.baseCurrencyName
        baseAmountTextField.delegate = self
        baseAmountTextField.addTarget(self, action: #selector(ExchangeViewController.textFieldTextDidChange(_:)), forControlEvents: .EditingChanged)
    }
    
    private func requestLatestCurrencyData() {
        NetworkRequestManager.exchangeRatesRequest(ExchangeViewController.baseCurrencyName, conversionCurrencies: ExchangeViewController.conversionCurrencyNames) { (rates, error) in
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
        print("Index Selected: \(index)")
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let textFieldText = textField.text {
            let proposedText = (textFieldText as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
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

}

// NB: Subclassing UITextField to override intrinsicContentSize and
// enable a dynamic width while user is typing
class DynamicWidthTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyDottedUnderlineToView(self, color: UIColor(red:0.30, green:0.27, blue:0.29, alpha:1.0))
    }
    
    func applyDottedUnderlineToView(view: UIView, color: UIColor) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.CGColor
        borderLayer.fillColor = nil
        borderLayer.lineWidth = 6
        borderLayer.lineDashPattern = [6, 3]
        borderLayer.path = UIBezierPath(rect: CGRectMake(0, view.bounds.height
            , view.bounds.width, 3)).CGPath
        view.layer.addSublayer(borderLayer)
    }
    
    override func intrinsicContentSize() -> CGSize {
        if let text = self.text {
            if (text.characters.count > 0) {
                let size = (text as NSString).sizeWithAttributes(ExchangeViewController.defaultTextFieldAttributes)
                return CGSizeMake(size.width, self.frame.height)
            }
        }
        return super.intrinsicContentSize()
    }
    
}

