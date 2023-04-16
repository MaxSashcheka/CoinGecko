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
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Assets.Colors.white.color
        
        title = "Create User Photo"
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(
            image: Assets.Images.cross.image,
            action: { [weak viewModel] in viewModel?.didTapCloseButton() }
        )
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.navigationItem.setHidesBackButton(true, animated: true)
//        }
//        
    }
}
