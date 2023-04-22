//
//  ComposeUserPhotoViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class ComposeUserPhotoViewController: ViewController {
    
    private let photoImageView: UIImageView = .make {
        $0.backgroundColor = Assets.Colors.lightGray.color
        $0.clipsToBounds = true
    }
    
    private let cameraPlaceholderImage = UIImageView(image: Assets.Images.camera.image)
    
    private let pickPhotoButton: Button = .make {
        $0.backgroundColor = Assets.Colors.blue.color.withAlphaComponent(0.7)
        $0.setTitle("Choose photo", for: .normal)
    }
    
    private let finishButton: Button = .make {
        $0.backgroundColor = Assets.Colors.blue.color.withAlphaComponent(0.7)
        $0.setTitle("Finish", for: .normal)
    }
    
    var buttons: [Button] { [pickPhotoButton, finishButton] }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Assets.Colors.white.color
        
        title = "Create User Photo"
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        photoImageView.layer.cornerRadius = photoImageView.bounds.width / 8
        buttons.forEach {
            $0.layer.cornerRadius = $0.bounds.height / 2
        }
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.selectedImage
            .bind(to: \.image, on: photoImageView)
            .store(in: &cancellables)
        
        let selectedImageSubject = viewModel.selectedImage.map { !$0.isNil }
        
        selectedImageSubject
            .bind(to: \.isHidden, on: cameraPlaceholderImage)
            .store(in: &cancellables)
        
        selectedImageSubject
            .bind(to: \.isEnabled, on: finishButton)
            .store(in: &cancellables)
        
        selectedImageSubject
            .map { Assets.Colors.blue.color.withAlphaComponent($0 ? 0.7 : 0.25) }
            .bind(to: \.backgroundColor, on: finishButton)
            .store(in: &cancellables)
        
        pickPhotoButton.tapPublisher()
            .sink { [weak viewModel] in
                viewModel?.didTapPickPhotoButton()
            }
            .store(in: &cancellables)
        
        finishButton.tapPublisher()
            .sink { [weak viewModel] in
                viewModel?.didTapFinishButton()
            }
            .store(in: &cancellables)
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        photoImageView.addSubview(cameraPlaceholderImage)
        cameraPlaceholderImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let buttonsStackView = UIStackView(axis: .vertical, spacing: 15, distribution: .fillEqually)
        
        view.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.leading.trailing.equalToSuperview().inset(35)
        }
        buttonsStackView.addArrangedSubviews(buttons)
        
        buttons.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
}
