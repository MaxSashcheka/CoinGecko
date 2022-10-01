//
//  Button+Rx.swift
//  Utils
//
//  Created by Maksim Sashcheka on 28.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


extension Reactive where Base: Button {
    /// Bindable sink for `title` property.
    public var title: Binder<String?> {
        Binder(self.base) { button, title -> Void in
            button.setTitle(title, for: .normal)
        }
    }
    
    public var isSelected: Binder<Bool> {
        Binder(self.base) { button, isSelected -> Void in
            button.isSelected = isSelected
        }
    }
}
