//
//  ProfileViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 27.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import SnapKit
import Utils

final class ProfileViewController: ViewController {
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
    }
}

