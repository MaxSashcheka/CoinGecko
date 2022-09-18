//
//  Button.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UIButton

open class Button: UIButton {
    public convenience init(image: UIImage) {
        self.init()
        
        setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
