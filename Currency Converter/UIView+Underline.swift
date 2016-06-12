//
//  UIView+Underline.swift
//  Currency Converter
//
//  Created by Phill Farrugia on 13/06/2016.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

extension UIView {
    
    static func applyDottedUnderlineToView(view: UIView, color: UIColor) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.CGColor
        borderLayer.fillColor = nil
        borderLayer.lineWidth = 3
        borderLayer.lineDashPattern = [4, 2]
        borderLayer.path = UIBezierPath(rect: CGRectMake(0, view.bounds.height, view.bounds.width, 6)).CGPath
        view.layer.addSublayer(borderLayer)
    }
    
}
