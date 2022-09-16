//
//  ViewController.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import UIKit.UIViewController
import RxSwift

open class ViewController: UIViewController {

    open var isNavigationBarHidden: Bool { false }
    open var isToolbarHidden: Bool { true }
    open var backgroundColor: UIColor { .white }
    
    let disposeBag = DisposeBag()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor

        arrangeSubviews()
        setupData()
        bindData()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: animated)
        navigationController?.setToolbarHidden(isToolbarHidden, animated: animated)
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
}
