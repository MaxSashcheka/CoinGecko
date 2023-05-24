//
//  ActivityIndicatorController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 9.05.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import NVActivityIndicatorView
import Utils

open class ActivityIndicatorController: ModalWindowViewController {
    private let indicatorView = NVActivityIndicatorView(
        frame: .zero,
        type: .ballTrianglePath,
        color: Assets.Colors.blue.color.withAlphaComponent(0.7),
        padding: 20
    )
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Assets.Colors.darkGray.color.withAlphaComponent(0.5)
        indicatorView.backgroundColor = Assets.Colors.white.color
        indicatorView.isHidden = false
        indicatorView.layer.cornerRadius = 20
        indicatorView.startAnimating()
    }
    
    open override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(120)
        }
    }
}
