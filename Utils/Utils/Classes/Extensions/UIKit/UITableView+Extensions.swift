//
//  UITableView+Extensions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 25.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UITableView

public extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func reuse<T: UITableViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
}
