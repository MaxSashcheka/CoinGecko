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
    private typealias Texts = L10n.General.Alert
    private typealias ErrorAlert = (title: String, message: String?)
    
    func showAlert(_ error: AnyError, completion: Closure.Void? = nil) {
        let (title, message) = errorAlert(from: error)
        let closeActionClosure = closeAction(completion: completion)

        showAlert(title: title, message: message, actions: [closeActionClosure])
    }
    
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

    func action(title: String,
                style: UIAlertAction.Style = .default,
                completion: Closure.Void? = nil) -> UIAlertAction {
        UIAlertAction(title: title, style: style, handler: { _ in completion?() })
    }

    func destructiveAction(title: String,
                           completion: Closure.Void? = nil) -> UIAlertAction {
        action(title: title, style: .destructive, completion: completion)
    }
    
    func closeAction(completion: Closure.Void? = nil) -> UIAlertAction {
        action(title: Texts.close, style: .cancel, completion: completion)
    }
    
    func cancelAction(completion: Closure.Void? = nil) -> UIAlertAction {
        action(title: Texts.cancel, style: .cancel, completion: completion)
    }
}

private extension AppAlertCoordinator {
    private func errorAlert(from error: AnyError) -> ErrorAlert {
        var message = String.empty

        message += Constants.errorSeparator + error.firstMessage.orEmpty()
        message += Constants.errorSeparator + error.recursiveCode
        let localizedDescription = error.fullRecursiveLocalizedDescription
        if !localizedDescription.isEmpty {
            message += Constants.errorSeparator + localizedDescription
        }
        message += Constants.errorSeparator + error.recursiveMethods
        message += Constants.errorSeparator + "DEBUG FULL RECURSIVE INFO" + Constants.errorSeparator + error.fullRecursiveInfo
        
        return (title: "Error", message: message.isEmpty ? nil : message)
    }

    enum Constants {
        static let errorSeparator = "\n --------- \n"
    }
}
