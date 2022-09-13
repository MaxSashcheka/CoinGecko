//
//  NavigationController.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//

import UIKit

/**
Internal navigation controller back button deegate.
*/
protocol NavigationControllerBackButtonDelegate: AnyObject {
    func navigationControllerShouldPopByBackButton(_ navigationController: UINavigationController) -> Bool
}

/**
Internal navigation controller class can helps handle back button touch event.
*/
class NavigationController: UINavigationController, UINavigationBarDelegate {
    weak var backButtonDelegate: NavigationControllerBackButtonDelegate?

    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if #available(iOS 13, *) {
            guard topViewController?.navigationItem == item else { return true }
            return backButtonDelegate?.navigationControllerShouldPopByBackButton(self) ?? true
        } else {
            // Strange method behaviour less than iOS 13. Need to pop controller manually
            // https://stackoverflow.com/questions/20327165/popviewcontroller-strange-behaviour/20327367#20327367
            // https://stackoverflow.com/questions/42581851/uinavigationbardelegate-shouldpop-item-weird-behavior
            var result = true
            defer {
                if result { popViewController(animated: true) }
            }
            guard topViewController?.navigationItem == item else { return result }
            result = backButtonDelegate?.navigationControllerShouldPopByBackButton(self) ?? true
            return result
        }
    }
}

