//
//  WalletDetailsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class WalletDetailsViewController: ViewController {
    override var backgroundColor: UIColor { Assets.Colors.white.color }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButtonItem(
            image: UIImage(.trash),
            action: { [weak viewModel] in viewModel?.didTapDeleteWalletButton() }
        )
        
        viewModel.errorHandlerClosure = errorHandler
    }
    
    override func arrangeSubviews() {
        super.arrangeSubviews()
        
        
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.walletTitle
            .bind(to: \.title, on: self)
            .store(in: &cancellables)
    }
    
    override func setupData() {
        super.setupData()
    }
}
