//
//  AddCoinOverlayViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 30.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import SnapKit
import Utils

final class AddCoinOverlayViewController: ViewController {
    typealias Texts = L10n.Overlay.Coin
    
    // MARK: - Properties
    
    private let indicatorView = View(backgroundColor: .lightGray)
    
    private let descriptionLabel: Label = {
        let label = Label()
        label.text = Texts.title
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .darkGray
        label.textAlignment = .center
        
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        textField.font = .systemFont(ofSize: 30, weight: .semibold)
        textField.tintColor = .black
        
        return textField
    }()
    
    private let textFieldBottomLine = View(backgroundColor: .darkGray)
    
    private let addButton = Button(title: Texts.Button.title, backgroundColor: .systemBlue.withAlphaComponent(0.65))
    
    private var keyboardIsShown = false
    private var hasSetOriginPoint = false
    private var originPoint: CGPoint?
    
    private var rootPresentationController: PresentationController? {
        presentationController as? PresentationController
    }
    var blurEffectAlpha: CGFloat {
        get { rootPresentationController?.blurEffectView.alpha ?? .zero }
        set { rootPresentationController?.blurEffectView.alpha = newValue }
    }
    var initialBlurEffectAlpha: CGFloat = .zero
    
    var viewModel: ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.errorHandlerClosure = errorHandler
        
        activateEndEditingTap(at: view)
        viewModel.fillAmountInfoIfPossible()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        initialBlurEffectAlpha = blurEffectAlpha
        
        [indicatorView, textFieldBottomLine, addButton].forEach {
            $0.layer.cornerRadius = $0.frame.height / 2
        }
        
        if !hasSetOriginPoint {
            hasSetOriginPoint = true
            originPoint = self.view.frame.origin
        }
        
        view.apply(cornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner], withCornerRadius: 30)
    }
    
    // MARK: - Methods
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(5)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(indicatorView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(amountTextField)
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(40)
        }
        
        view.addSubview(textFieldBottomLine)
        textFieldBottomLine.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom)
            make.leading.trailing.equalTo(amountTextField)
            make.height.equalTo(3)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldBottomLine.snp.bottom).offset(40)
            make.leading.trailing.equalTo(textFieldBottomLine)
            make.height.equalTo(50)
        }
    }
    
    override func bindData() {
        super.bindData()
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                guard let self = self,
                      let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                      let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
                      else { return }
                let keyboardHeight = keyboardFrame.cgRectValue.height
                UIView.animate(withDuration: animationDuration) {
                    self.view.frame.origin = .init(x: .zero,
                                                   y: UIScreen.main.bounds.height - keyboardHeight - self.view.frame.height)
                }
                self.keyboardIsShown.toggle()
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                guard let self = self,
                      let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
                      else { return }
                UIView.animate(withDuration: animationDuration) {
                    self.view.frame.origin = .init(x: .zero, y: self.originPoint?.y ?? .zero)
                }
                self.keyboardIsShown.toggle()
            }
            .store(in: &cancellables)
        
        view.panPublisher()
            .sink { [weak self] gesture in
                guard let self = self else { return }
                let translation = gesture.translation(in: self.view)

                let originPoint = self.originPoint ?? .zero
                
                guard translation.y >= .zero, !self.keyboardIsShown else { return }
                self.view.frame.origin = .init(x: .zero, y: originPoint.y + translation.y)
                
                self.updateBlurEffectAlpha(translation: translation.y)
                
                if gesture.state == .ended {
                    if translation.y > self.view.frame.height / 3 {
                        self.viewModel.didTriggerCloseAction()
                    } else {
                        UIView.animate(withDuration: 0.3) {
                            self.view.frame.origin = originPoint
                            self.blurEffectAlpha = self.initialBlurEffectAlpha
                        }
                    }
                }
            }
            .store(in: &cancellables)
        
        addButton.tapPublisher()
            .sink { [weak self, weak viewModel] in
                guard let self = self, let viewModel = viewModel else { return }
                viewModel.didTapAddButton(amountText: self.amountTextField.text ?? .empty)
            }
            .store(in: &cancellables)
        
        viewModel.amountText
            .bind(to: \.text, on: amountTextField)
            .store(in: &cancellables)
        
        viewModel.incorrectNumberSubject
            .sink { [weak textFieldBottomLine] in
                textFieldBottomLine?.backgroundColor = .red
            }
            .store(in: &cancellables)
    }
}

// MARK: - AddCoinOverlayViewController+Constants
private extension AddCoinOverlayViewController {
    func updateBlurEffectAlpha(translation: CGFloat) {
        let translationProgress = translation / view.frame.height
        let newAlpha = initialBlurEffectAlpha - translationProgress
        blurEffectAlpha = newAlpha
    }
}

// MARK: - AddCoinOverlayViewController+EndEditingTappable
extension AddCoinOverlayViewController: EndEditingTappable { }
