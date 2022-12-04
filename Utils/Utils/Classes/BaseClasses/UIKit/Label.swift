//
//  Label.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UILabel

open class Label: UILabel {
    public convenience init(textPreferences: TextPreferences) {
        self.init()
        
        font = textPreferences.font
        textColor = textPreferences.textColor
    }
}


