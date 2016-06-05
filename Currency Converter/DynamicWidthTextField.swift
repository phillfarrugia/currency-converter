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
    
    static private let defaultTextFieldAttributes: [String: AnyObject] = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: 44)!
    ]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyDottedUnderlineToView(self, color: UIColor(red:0.30, green:0.27, blue:0.29, alpha:1.0))
    }
    
    func applyDottedUnderlineToView(view: UIView, color: UIColor) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.CGColor
        borderLayer.fillColor = nil
        borderLayer.lineWidth = 6
        borderLayer.lineDashPattern = [4, 2]
        borderLayer.path = UIBezierPath(rect: CGRectMake(0, view.bounds.height
            , view.bounds.width, 3)).CGPath
        view.layer.addSublayer(borderLayer)
    }
    
    override func intrinsicContentSize() -> CGSize {
        if let text = self.text {
            if (text.characters.count > 0) {
                let size = (text as NSString).sizeWithAttributes(DynamicWidthTextField.defaultTextFieldAttributes)
                return CGSizeMake(size.width, self.frame.height)
            }
        }
        return super.intrinsicContentSize()
    }
    
}
