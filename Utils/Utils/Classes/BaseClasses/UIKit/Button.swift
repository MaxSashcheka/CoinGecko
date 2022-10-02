//
//  Button.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit.UIButton

open class Button: UIButton {
    public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    public var textColor: UIColor {
        get { titleLabel?.textColor ?? .black }
        set { setTitleColor(newValue, for: .normal) }
    }
    
    public var text: String {
        get { titleLabel?.text ?? .empty }
        set { setTitle(newValue, for: .normal) }
    }
    
    public var font: UIFont {
        get { titleLabel?.font ?? UIFont() }
        set { titleLabel?.font = newValue }
    }
    
    open var cancellables: [AnyCancellable] = []
    
    public convenience init(image: UIImage) {
        self.init()
        
        setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
