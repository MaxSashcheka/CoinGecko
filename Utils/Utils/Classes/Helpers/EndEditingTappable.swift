//
//  EndEditingTappable.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import UIKit

/// Allows to add endEditing behavior for specific view
public protocol EndEditingTappable: AnyObject {
    func activateEndEditingTap(at view: UIView)
}

public extension EndEditingTappable {
    func activateEndEditingTap(at view: UIView) {
        view.tapPublisher()
            .strongSink { $0.view?.endEditing(true) }
    }
}
