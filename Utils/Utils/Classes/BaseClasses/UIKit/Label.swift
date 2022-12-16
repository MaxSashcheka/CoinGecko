//
//  Label.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UILabel

open class Label: UILabel {
    public func apply(_ style: TextStyle) {
        self.font = style.font
        self.textColor = style.textColor
    }
}


