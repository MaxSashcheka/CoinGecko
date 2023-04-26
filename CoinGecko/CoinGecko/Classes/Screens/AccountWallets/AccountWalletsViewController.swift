//
//  AccountWalletsViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Combine
import SafeSFSymbols
import SnapKit
import Utils

final class AccountWalletsViewController: ViewController {
    
    override var backgroundColor: UIColor { Assets.Colors.white.color }
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Account Wallets"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButtonItem(
            image: UIImage(.plus),
            action: { [weak viewModel] in viewModel?.didTapComposeWalletButton() }
        )
        
        viewModel.errorHandlerClosure = errorHandler
    }
}
