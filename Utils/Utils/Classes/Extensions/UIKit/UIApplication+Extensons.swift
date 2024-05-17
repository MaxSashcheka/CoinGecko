//
//  UIApplication+Extensons.swift
//  Utils
//
//  Created by Maksim Sashcheka on 25.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit.UIApplication

public extension UIApplication {
    @discardableResult
    func openLinkIfCan(_ link: URL) -> Bool {
        guard UIApplication.shared.canOpenURL(link) else { return false }
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
        return true
    }
}
