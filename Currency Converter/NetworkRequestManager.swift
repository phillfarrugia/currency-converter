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
    
    typealias ExchangeRatesRequestCompletion = (rates: [Currency]?, error: NSError?) -> Void
    
    static func exchangeRatesRequest(baseCurrency: String, conversionCurrencies: [String], completion: ExchangeRatesRequestCompletion) {
        let currenciesQueryString = conversionCurrencies.joinWithSeparator(",")
        guard let requestURL = NSURL(string: "\(baseURL)/latest?base=\(baseCurrency)&symbols=\(currenciesQueryString)") else { return }
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            if let error = error {
                completion(rates: nil, error: error)
            }
            else {
                
            }
        }
    }
    
    typealias RequestCompletion = (JSON: [String: AnyObject]?, error: NSError?) -> Void
    
    static func performNetworkRequest(request: NSURLRequest, completion: RequestCompletion) {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            // Request Failed
            if let error = error {
                completion(JSON: nil, error: error)
            }
            
            // Parse Data into Dictionary
            if let JSON = data as? [String: AnyObject] {
                completion(JSON: JSON, error: nil)
            }
            else {
                // Parsing Failed
                return completion(JSON: nil, error: nil)
            }
        }
    }
    
}
