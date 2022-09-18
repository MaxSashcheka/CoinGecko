//
//  View.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UIView

open class View: UIView {
    public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    public convenience init(shadowColor: UIColor = .clear,
                            shadowOffset: CGSize = .zero,
                            shadowRadius: CGFloat = .zero,
                            shadowOpacity: Float = .zero) {
        self.init()
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
}
