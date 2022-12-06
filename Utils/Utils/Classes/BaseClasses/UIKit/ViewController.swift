//
//  ViewController.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit.UIViewController

open class ViewController: UIViewController {

    open var isNavigationBarHidden: Bool { false }
    open var isTabBarHidden: Bool { false }
    open var isToolbarHidden: Bool { true }
    open var prefersLargeTitles: Bool { false }
    open var backgroundColor: UIColor { .white }
    
    open var tabBarTitle: String { .empty }
    open var tabBarImage: UIImage? { .none }
    
    public var cancellables: [AnyCancellable] = []
    public private(set) var isAppearFirstTime = true
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setupTabBarItems()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupTabBarItems()
    }
    
    // TODO: - Fix this async call.
    private func setupTabBarItems() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, self.navigationController?.tabBarItem.image == nil else { return }
            
            self.navigationController?.tabBarItem.title = self.tabBarTitle
            self.navigationController?.tabBarItem.image = self.tabBarImage
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles

        arrangeSubviews()
        setupData()
        bindData()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.setTabBarHidden(isTabBarHidden, animated: true)
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: animated)
        navigationController?.setToolbarHidden(isToolbarHidden, animated: animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isAppearFirstTime = false
    }
    
    open func arrangeSubviews() {
        // Override at subclasses
    }
    
    open func bindData() {
        // Override at subclasses
    }

    open func setupData() {
        // Override at subclasses
    }
    
    public var errorHandler: Closure.GeneralError {
        { [weak self] error in
            ActivityIndicator.hide()
            let alert = UIAlertController(title: "Error Appeared !",
                                          message: error.rawValue,
                                          preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

private extension UITabBarController {
    func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        guard let vc = selectedViewController else { return }
        guard tabBarHidden != hidden else { return }
        
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = hidden ? height : -height

        UIViewPropertyAnimator(duration: animated ? 0.3 : .zero, curve: .easeOut) { [weak self] in
            guard let self = self else { return }
            
            self.tabBar.frame = self.tabBar.frame.offsetBy(dx: .zero, dy: offsetY)
            self.selectedViewController?.view.frame = CGRect(
                x: .zero,
                y: .zero,
                width: vc.view.frame.width,
                height: vc.view.frame.height + offsetY
            )
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
        .startAnimation()
    }
    
    private var tabBarHidden: Bool {
        tabBar.frame.origin.y >= UIScreen.main.bounds.height
    }
}
