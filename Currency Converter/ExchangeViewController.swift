//
//  ViewController.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController, CurrencySelectorViewDelegate {
    
    @IBOutlet weak private var currencySelectorView: CurrencySelectorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currencySelectorView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: CurrencySelectorViewDelegate
    
    func numberOfItems() -> Int {
        return 0
    }
    
    func textForItemAtIndex(index: Int) -> String {
        return ""
    }
    
    func selectorDidSelectItemAtIndex(index: Int) {
        // TODO: Do something when a user selects a specific currency
    }

}

