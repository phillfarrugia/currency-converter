//
//  NetworkRequestManager.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

class NetworkRequestManager {
    
    static let baseURL = "https://api.fixer.io"
    
    // MARK: Exchange Rates Request
    
    typealias ExchangeRatesRequestCompletion = (rates: [Currency]?, error: NSError?) -> Void
    
    /**
     Requests the latest exchange rate data for provided currencies from the network against a provided base currency.
     - parameter baseCurrency:	base currency used to determine exchange rates
     - parameter conversionCurrencies: currencie codes to retrieve rates for
     - parameter completion: a completion block that returns an array of currencies or an error.
     */
    static func exchangeRatesRequest(baseCurrency: String, conversionCurrencies: [String], completion: ExchangeRatesRequestCompletion) {
        let currenciesQueryString = conversionCurrencies.joinWithSeparator(",")
        guard let requestURL = NSURL(string: "\(baseURL)/latest?base=\(baseCurrency)&symbols=\(currenciesQueryString)") else { return }
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        performNetworkRequest(request) { (dict, error) in
            if let error = error {
                dispatch_async(dispatch_get_main_queue(), {
                    completion(rates: nil, error: error)
                })
            }
            
            // Map JSON Dictionary into Currency Models and pass to completion
            if let dict = dict, let rates = dict["rates"] as? [String: AnyObject] {
                let currencies = Currency.currenciesWithDictionaries(rates)
                dispatch_async(dispatch_get_main_queue(), { 
                    completion(rates: currencies, error: nil)
                })
            }
        }
    }
    
    // MARK: Perform Network Request
    
    typealias RequestCompletion = (JSON: [String: AnyObject]?, error: NSError?) -> Void
    
    /**
     Performs an asynchronous network request and serializes the response JSON data
     into a Dictionary or error if the request fails.
     - parameter request: url request to peform
     - parameter completion: completion block that returns a dictionary or an error
     */
    static func performNetworkRequest(request: NSURLRequest, completion: RequestCompletion) {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            // Request Failed
            guard error == nil else {
                completion(JSON: nil, error: error)
                return
            }
            
            // Serialise JSON data -> Dictionary
            if let data = data {
                do {
                    let JSON = try NSJSONSerialization.dictionaryWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? [String: AnyObject]
                    completion(JSON: JSON, error: nil)
                }
                catch let JSONError as NSError {
                    completion(JSON: nil, error: JSONError)
                }
            }
        }
        
        dataTask.resume()
    }
    
}
