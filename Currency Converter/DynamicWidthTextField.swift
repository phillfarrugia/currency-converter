//
//  DynamicWidthTextField.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 5/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import UIKit

// NB: Subclassing UITextField to override intrinsicContentSize and
// enable a dynamic width while user is typing
class DynamicWidthTextField: UITextField {
    
    static private let kHorizontalMargin: CGFloat = 1.0
    
    static let defaultTextFieldAttributes: [String: AnyObject] = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: 44)!
    ]
    
    override func intrinsicContentSize() -> CGSize {
        if let text = self.text {
            if (text.characters.count > 0) {
                let size = (text as NSString).sizeWithAttributes(DynamicWidthTextField.defaultTextFieldAttributes)
                return CGSizeMake(size.width + DynamicWidthTextField.kHorizontalMargin, self.frame.height)
            }
        }
        return super.intrinsicContentSize()
    }
    
}
