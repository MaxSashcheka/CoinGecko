//
//  HomeViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class HomeViewController: ViewController {
    private let settingsButton: Button = {
        let button = Button()
        button.setImage(Assets.Images.settings.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .darkGray

        return button
    }()
    
    override var isNavigationBarHidden: Bool { true }
    
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var tabBarTitle: String { "Home" }
    override var tabBarImage: UIImage? { UIImage(systemName: "house") }
    
    var viewModel: ViewModel!
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        settingsButton.tapPublisher()
            .sink { [weak viewModel] in
                viewModel?.didTapSettingsButton()
            }
            .store(in: &cancellables)
    }
    
}
