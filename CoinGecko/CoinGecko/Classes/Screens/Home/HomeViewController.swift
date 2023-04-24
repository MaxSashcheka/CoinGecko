//
//  HomeViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 10.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class HomeViewController: ViewController {

    private let placeholderView = SignInPlaceholderView()
    
    override var backgroundColor: UIColor { Assets.Colors.platinum.color }
    override var tabBarTitle: String { L10n.Tabbar.Title.home }
    override var tabBarImage: UIImage? { UIImage(.house) }
    
    var viewModel: ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(placeholderView)
        placeholderView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(45)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.placeholderViewModel.tapSubject
            .filter { $0 == .signIn }
            .sink { [weak viewModel] _ in
                print("didTapSignInButton")
                viewModel?.didTapSignInButton()
            }
            .store(in: &cancellables)
        
        viewModel.placeholderViewModel.tapSubject
            .filter { $0 == .signUp }
            .sink { [weak viewModel] _ in
                print("didTapSignUpButton")
                viewModel?.didTapSignUpButton()
            }
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
    
        placeholderView.viewModel = viewModel.placeholderViewModel
    }
}
