//
//  EndEditingTappable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 9.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit
import Utils

/// Allows to add endEditing behavior for specific view
public protocol EndEditingTappable: AnyObject {
    func activateEndEditingTap(at view: UIView)
}

public extension EndEditingTappable where Self: ViewController {
    func activateEndEditingTap(at view: UIView) {
        view.tapPublisher()
            .sink { $0.view?.endEditing(true) }
            .store(in: &cancellables)
    }
}
