//
//  ModalWindowViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 4.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit
import Utils

open class ModalWindowViewController: ViewController {
    private var containerWindow: UIWindow?
    
    func show(animated: Bool = true) {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .fullScreen

        // Refactor logic to get current windowScene
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let windowScene = sceneDelegate.window?.windowScene else { return }
        
        containerWindow = UIWindow(windowScene: windowScene)
        containerWindow?.rootViewController = UIViewController()
        containerWindow?.windowLevel = (UIApplication.shared.windows.last?.windowLevel ?? UIWindow.Level.alert) + 1
        containerWindow?.makeKeyAndVisible()
        containerWindow?.rootViewController?.present(self, animated: animated, completion: nil)
    }
    
    func hide(animated: Bool = true) {
        dismiss(animated: animated, completion: nil)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        containerWindow?.isHidden = true
        containerWindow = nil
    }
}
