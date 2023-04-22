//
//  UIBarButtonItem.swift
//  Utils
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import UIKit

public extension UIBarButtonItem {
    private struct AssociatedObject {
        static var key = "action_closure_key"
    }
    
    var actionClosure: Closure.Void? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObject.key) as? Closure.Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObject.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            target = self
            action = #selector(didTapButton(sender:))
        }
    }
    
    @objc func didTapButton(sender: Any) {
        actionClosure?()
    }
    
    static func barButtonItem(image: UIImage,
                              action: @escaping Closure.Void) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        item.actionClosure = action
        return item
    }
}
