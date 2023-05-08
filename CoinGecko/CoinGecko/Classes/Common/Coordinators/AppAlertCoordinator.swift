//
//  AppAlertCoordinator.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 4.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit
import Utils

class AppAlertCoordinator {
//    func showAlert(_ error: AnyError, completion: VoidClosure? = nil) {
//        let (title, message, type) = errorAlert(from: error)
//        let closeActionClosure = closeAction { [weak self] in
//            self?.activeErrorAlerts.removeAll(where: { $0 == type })
//            completion?()
//        }
//
//        if Build.configuration != .develop {
//            guard !activeErrorAlerts.contains(type) else { return }
//        }
//        activeErrorAlerts.append(type)
//        showAlert(title: title, message: message, actions: [closeActionClosure])
//    }
    
    func showAlert(title: String, message: String? = nil, actions: [UIAlertAction]) {
        let alert = OverlayAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        alert.show()
    }
    
    func showInfo(title: String, message: String? = nil) {
        let alert = OverlayAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(closeAction())
        alert.show()
    }

    func action(title: String, style: UIAlertAction.Style = .default, completion: Closure.Void? = nil) -> UIAlertAction {
        UIAlertAction(title: title, style: style, handler: { _ in completion?() })
    }

    func destructiveAction(title: String, completion: Closure.Void? = nil) -> UIAlertAction {
        action(title: title, style: .destructive, completion: completion)
    }
    
    func closeAction(completion: Closure.Void? = nil) -> UIAlertAction {
        action(title: "Close", style: .cancel, completion: completion)
    }
    
    func cancelAction(completion: Closure.Void? = nil) -> UIAlertAction {
        action(title: "Cancel", style: .cancel, completion: completion)
    }
}
