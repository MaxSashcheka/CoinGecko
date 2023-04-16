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
    
    private let button: Button = .make {
        $0.backgroundColor = .blue
        $0.setTitle("Button title", for: .normal)
    }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.transform = CGAffineTransform(scaleX: .zero, y: .zero)
        
        title = "Create User"
        
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
            UIView.animate(withDuration: 1, delay: .zero, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: []) {
                self.button.transform = .identity
            } completion: { _ in }
        }
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(60)
        }
    }
}
