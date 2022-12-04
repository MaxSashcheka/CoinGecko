//
//  MakeView.swift
//  Utils
//
//  Created by Max Sashcheka on 3.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UIView

public func makeView<T: UIView>(_ closure: (T) -> Void) -> T {
    let view = T()
    closure(view)
    return view
}
