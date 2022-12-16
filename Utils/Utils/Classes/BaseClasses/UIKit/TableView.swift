//
//  TableView.swift
//  Utils
//
//  Created by Maksim Sashcheka on 6.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UITableView

public final class TableView: UITableView {
    public static func make(style: UITableView.Style = .plain,
                            closure: (TableView) -> Void) -> TableView {
        let tableView = TableView(frame: .zero, style: style)
        closure(tableView)
        return tableView
    }
}
