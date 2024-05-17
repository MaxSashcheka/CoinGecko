//
//  TabCoordinator.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit

/**
 Custom coordinator represents capabilities of tab bar controller: You can use multiple child controllers and navigate between them by 'tabs'.
 Use it to implement tab bar based routing logic.
 By default this class implements only base tab bar controller logic. Subclass it to add specipic behavior.
 */
open class TabCoordinator: Coordinator {
    /// Strong reference to tab bar controller
    private var innerTabBarController: UITabBarController?

    /// Initialized tab bar controller's property. In case tab bar controller is not initialized calls *loadNavigationController()* method (Similar to *loadView()* pattern of UIViewController class).
    open var tabBarController: UITabBarController {
        get {
            if let controller = innerTabBarController {
                return controller
            }
            
            loadTabBarController()
            
            guard let controller = innerTabBarController else {
                fatalError("Model.TabCoordinator.tabBarController\n" +
                    "'tabBarController' variable should be initialized after 'loadTabBarController' method call.")
            }
            tabControllerDidLoad()
            return controller
        }
        set {
            innerTabBarController = newValue
        }
    }
    
    /// Overrided property of 'Coordinator' class.
    /// Returns the same object as *navigationController* property.
    override open var baseViewController: UIViewController {
        tabBarController
    }
    
    /// Overrided property of 'Coordinator' class.
    /// Returns the selected view controller of tab bar controller
    override open var activeViewController: UIViewController? {
        tabBarController.selectedViewController
    }
    
    open var activeCoordinator: TabContentCoordinator? {
        children
            .compactMap { $0 as? TabContentCoordinator }
            .first(where: { $0.baseViewController == activeViewController })
    }
    
    /// Creates the tab bar controller that the coordinator manages. You should never call this method directly.
    /// The tab bar coordinator  calls method when its tab bar controller is never beeng initialized.
    /// The default implementation of this method creates object of *PresentableTabBarController* class and assigns it to *tabBarController* property.
    /// Override this method to assign custom tab bar controller.
    open func loadTabBarController() {
        tabBarController = UITabBarController()
    }
    
    open func tabControllerDidLoad() {
       
    }
    
    /// Set selected coordinators to TabBarController.
    /// Coordinators objects should be initialized and put in the array in the same order
    /// as they should appear in a tab bar controller.
    /// - parameter coordinators: coordinators objects that will be set as tabs
    /// - parameter animated: if setting tabs will be animated or not
    open func setTabs(_ coordinators: [TabContentCoordinator], animated: Bool) {
        coordinators.forEach {
            add(child: $0)
            $0.baseViewController.tabBarItem = $0.tab.item
        }
        
        tabBarController.setViewControllers(coordinators.map { $0.baseViewController }, animated: animated)
        
        selectDefaultTab()
    }
    
    /// Select the first tab as default according to the children's order.
    /// Throws assert if couldn't find a required child.
    open func selectDefaultTab() {
        guard let firstTab = children.first as? TabContentCoordinator else {
            assertionFailure("Couldn't find the first tab into the '\(self)'")
            return
        }
        
        selectCoordinator(type(of: firstTab))
    }
    
    /// Select base view controller of coordinator with given type.
    /// Throws assert if either coordinator with given type is not found or coordinator's controller is not child controller of tab bar controller.
    /// - parameter type: view controller's type to find
    open func selectCoordinator<CoordinatorType: TabContentCoordinator>(_ type: CoordinatorType.Type) {
        guard let coordinator = childCoordinator(withType: type) else {
            assertionFailure("Model.TabCoordinator.selectViewController(withCoordinatorType:)\n" +
                "Could not find coordinator with type <\(type)>")
            return
        }
        
        guard tabBarController.viewControllers?.contains(coordinator.baseViewController) ?? false else {
            assertionFailure("Model.TabCoordinator.selectViewController(withCoordinatorType:)\n" +
                "Tab bar controller does not contain coordinator's base view controller")
            return
        }

        tabBarController.selectedViewController = coordinator.baseViewController
    }
}

open class TabContentCoordinator: NavigationCoordinator {
    public struct Tab: Equatable {
        public let title: String
        public let unselectedIcon: UIImage
        public let selectedIcon: UIImage
        
        public init(title: String,
                    unselectedIcon: UIImage,
                    selectedIcon: UIImage) {
            self.title = title
            self.unselectedIcon = unselectedIcon
            self.selectedIcon = selectedIcon
        }
    }
    
    public let tab: Tab
    
    public init(tab: Tab, parent: TabCoordinator?) {
        self.tab = tab

        super.init(parent: parent)
    }
}

private extension TabContentCoordinator.Tab {
    var item: UITabBarItem {
        UITabBarItem(
            title: title,
            image: unselectedIcon,
            selectedImage: selectedIcon
        )
    }
}
