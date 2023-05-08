//
//  OverlayAlertController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 4.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit

open class OverlayAlertController: ModalWindowViewController {
    public let alertController: UIAlertController
    
    public convenience init() {
        self.init(title: nil, message: nil, preferredStyle: .alert)
    }
    
    public init(title: String?, message: String?, preferredStyle: UIAlertController.Style) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertController.view.tintColor = Assets.Colors.blue.color.withAlphaComponent(0.7)

        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        alertController = UIAlertController()
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Assets.Colors.darkGray.color.withAlphaComponent(0.5)
    }
    
    open override func arrangeSubviews() {
        super.arrangeSubviews()
        
        addChild(alertController)
        alertController.didMove(toParent: self)
        view.addSubview(alertController.view)
        
        alertController.view.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    open func addAction(_ action: UIAlertAction) {
        alertController.addAction(action)
    }
}
