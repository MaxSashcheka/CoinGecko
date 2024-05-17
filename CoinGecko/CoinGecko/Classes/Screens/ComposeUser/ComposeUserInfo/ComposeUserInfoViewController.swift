//
//  ComposeUserInfoViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class ComposeUserInfoViewController: ViewController {
    private typealias Texts = L10n.CreateUser
    
    // MARK: - UI Components
    
    private let contentScrollView = UIScrollView()
    
    private let contentStackView: UIStackView = .make {
        $0.axis = .vertical
        $0.spacing = 15
    }
    
    private let continueButton: Button = .make {
        $0.backgroundColor = Assets.Colors.blue.color.withAlphaComponent(0.7)
        $0.setTitle(Texts.continueButton, for: .normal)
    }
    
    private let usernameTitledTextField = TitledTextField()
    
    private let loginTitledTextField = TitledTextField()
    
    private let passwordTitledTextField: TitledTextField = .make {
        $0.setTextInputTraitsOptions(TextInputTraitsOptions.password)
    }
    
    private let emailTitledTextField: TitledTextField = .make {
        $0.setTextInputTraitsOptions(TextInputTraitsOptions.email)
    }
    
    private let userRoleSegmentedControl = UISegmentedControl(
        items: ViewModel.UserRole.allCases.map { $0.title }
    )

    private let showPersonalWebPageOptionPickerView = OptionPickerView()
    
    private let personalWebPageTitledTextField = TitledTextField()
       
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.transform = CGAffineTransform(scaleX: .zero, y: .zero)
        userRoleSegmentedControl.selectedSegmentIndex = .zero
        
        activateEndEditingTap(at: view)
        
        title = Texts.title
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
        
        view.backgroundColor = Assets.Colors.white.color
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1,
                           delay: .zero,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 2,
                           options: []) {
                self.continueButton.transform = .identity
            } completion: { _ in }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        continueButton.layer.cornerRadius = continueButton.bounds.height / 2
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentScrollView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview().inset(45)
            make.centerX.equalToSuperview()
        }
        
        contentStackView.addArrangedSubviews([
            usernameTitledTextField,
            loginTitledTextField,
            passwordTitledTextField,
            emailTitledTextField,
            userRoleSegmentedControl,
            showPersonalWebPageOptionPickerView,
            personalWebPageTitledTextField
        ])
        
        contentScrollView.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(45)
            make.top.equalTo(contentStackView.snp.bottom).offset(40)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        continueButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.viewModel.didTapShowComposeUserPhotoButton(
                    userRole: ViewModel.UserRole(
                        rawValue: self.userRoleSegmentedControl.selectedSegmentIndex
                    ) ?? .user
                )
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .filter { [unowned self] _ in self.personalWebPageTitledTextField.isFirstResponder }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                guard let self = self,
                      let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
                      let newHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height
                      else { return }
                UIView.animate(withDuration: animationDuration) {
                    self.contentScrollView.contentOffset.y -= newHeight
                }
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .filter { [unowned self] _ in self.personalWebPageTitledTextField.isFirstResponder }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                guard let self = self,
                      let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
                      let newHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height
                      else { return }
                UIView.animate(withDuration: animationDuration) {
                    self.contentScrollView.contentOffset.y += newHeight
                }
            }
            .store(in: &cancellables)
        
        viewModel.showPersonalWebPageOptionPickerViewModel.selectedOption
            .sink { [weak self] shouldShow in
                UIView.animate(withDuration: 0.33, animations: { [weak self] in
                    self?.personalWebPageTitledTextField.isHidden = !shouldShow
                })
            }
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
        
        usernameTitledTextField.viewModel = viewModel.usernameTitledTextFieldViewModel
        loginTitledTextField.viewModel = viewModel.loginTitledTextFieldViewModel
        passwordTitledTextField.viewModel = viewModel.passwordTitledTextFieldViewModel
        emailTitledTextField.viewModel = viewModel.emailTitledTextFieldViewModel
        personalWebPageTitledTextField.viewModel = viewModel.personalWebPageTitledTextFieldViewModel
        showPersonalWebPageOptionPickerView.viewModel = viewModel.showPersonalWebPageOptionPickerViewModel
    }
}

extension ComposeUserInfoViewController: EndEditingTappable { }
