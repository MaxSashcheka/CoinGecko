//
//  View.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit.UIView

open class View: UIView {
    public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    public var shadowColor: UIColor? {
        get { UIColor(cgColor: layer.shadowColor ?? .clear) }
        set { layer.shadowColor = newValue?.cgColor }
    }
    
    public var shadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    public var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    public var shadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    public var borderColor: UIColor? {
        get { UIColor(cgColor: layer.shadowColor ?? .clear) }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    public var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    open var cancellables: [AnyCancellable] = []
    
    public convenience init(shadowColor: UIColor = .clear,
                            shadowOffset: CGSize = .zero,
                            shadowRadius: CGFloat = .zero,
                            shadowOpacity: Float = .zero) {
        self.init()
        
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
    
    public convenience init(backgroundColor: UIColor) {
        self.init()
        
        self.backgroundColor = backgroundColor
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    open func initialize() {
        
    }
}
