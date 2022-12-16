//
//  TextField.swift
//  Utils
//
//  Created by Maksim Sashcheka on 6.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UITextField

open class TextField: UITextField {
    public func apply(_ style: TextStyle) {
        self.font = style.font
        self.tintColor = style.textColor
    }
}
