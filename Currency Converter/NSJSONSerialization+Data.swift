//
//  NSJSONSerialization+Data.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

extension NSJSONSerialization {
    
    /**
      Serializes NSData into a Dictionary or returns an NSError.
     - parameter data:	JSON data to parse
     - parameter options: JSON reading options
     - throws: throws if serialisation fails
     - returns: NSDictionary [String: AnyObject]
     */
    class func dictionaryWithData(data: NSData, options: NSJSONReadingOptions) throws -> NSDictionary {
        guard let dict: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: options) as? NSDictionary else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotParseResponse, userInfo: [NSLocalizedDescriptionKey: "Not a Dictionary"])
        }
        return dict
    }
    
}
