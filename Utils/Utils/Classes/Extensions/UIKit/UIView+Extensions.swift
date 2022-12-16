//
//  UIView.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UIView

public extension UIView {
    static func make<T: UIView>(_ closure: (T) -> Void) -> T {
        let view = T()
        closure(view)
        return view
    }
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func asImage() -> UIImage {
        UIGraphicsImageRenderer(bounds: bounds).image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func apply(cornerMask: CACornerMask, withCornerRadius cornerRadius: CGFloat) {
        layer.maskedCorners = cornerMask
        layer.cornerRadius = cornerRadius
    }
}
