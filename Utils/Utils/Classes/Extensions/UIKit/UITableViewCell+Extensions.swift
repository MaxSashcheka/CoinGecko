//
//  UITableViewCell.swift
//  Utils
//
//  Created by Maksim Sashcheka on 16.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UITableViewCell

public extension UITableViewCell {
    static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }
    static var reuseIdentifier: String { String(describing: self) }
}
