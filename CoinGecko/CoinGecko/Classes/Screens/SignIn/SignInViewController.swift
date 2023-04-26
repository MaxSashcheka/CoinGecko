//
//  SignInViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 24.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class SignInViewController: ViewController {
    
    // MARK: - UI Components
    
    private let loginTitledTextField = TitledTextField()
    
    private let passwordTitledTextField = TitledTextField()
    
    private let loginButton: Button = .make {
        $0.backgroundColor = Assets.Colors.blue.color.withAlphaComponent(0.7)
        $0.setTitle("Log in", for: .normal)
    }
    
    override var backgroundColor: UIColor { Assets.Colors.white.color }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
        
        activateEndEditingTap(at: view)
        
        title = "Sign In"
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1,
                           delay: .zero,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 2,
                           options: []) {
                self.loginButton.transform = .identity
            } completion: { _ in }
        }
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubviews([loginTitledTextField, passwordTitledTextField, loginButton])
        
        loginTitledTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(45)
            make.centerX.equalToSuperview()
        }
        
        passwordTitledTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTitledTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(45)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(45)
            make.bottom.equalToSuperview().offset(-70)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        loginButton.tapPublisher
            .sink { [weak viewModel] in
                viewModel?.didTapLoginButton()
            }
            .store(in: &cancellables)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginButton.layer.cornerRadius = loginButton.bounds.height / 2
    }
    
    override func setupData() {
        super.setupData()
        
        loginTitledTextField.viewModel = viewModel.loginTitledTextFieldViewModel
        passwordTitledTextField.viewModel = viewModel.passwordTitledTextFieldViewModel
    }
}

// MARK: - SignInViewController+EndEditingTappable
extension SignInViewController: EndEditingTappable { }
