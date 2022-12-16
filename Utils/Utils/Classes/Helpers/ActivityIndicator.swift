//
//  ActivityIndicator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 20.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation
import SVProgressHUD

public class ActivityIndicator {
    public struct Style {
        let style: SVProgressHUDStyle
        let foregroundColor: UIColor
        let maskType: SVProgressHUDMaskType
        let minimumSize: CGSize
        
        public static let `default` = Style(foregroundColor: .gray)
        
        init(style: SVProgressHUDStyle = .custom,
             foregroundColor: UIColor,
             maskType: SVProgressHUDMaskType = .gradient,
             minimumSize: CGSize = CGSize(width: 100, height: 100)) {
            self.style = style
            self.foregroundColor = foregroundColor
            self.maskType = maskType
            self.minimumSize = minimumSize
        }
    }
    
    public static func show(style: Style = .default) {
        ActivityIndicator.applyStyle(style: style)
        SVProgressHUD.show()
    }
    
    public static func hide() {
        SVProgressHUD.dismiss()
    }
    
    static func applyStyle(style: Style) {
        SVProgressHUD.setDefaultStyle(style.style)
        SVProgressHUD.setForegroundColor(style.foregroundColor)
        SVProgressHUD.setDefaultMaskType(style.maskType)
        SVProgressHUD.setMinimumSize(style.minimumSize)
    }
    
    
}
