//
//  ComposeUserPhotoViewController.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

final class ComposeUserPhotoViewController: BaseComposePhotoViewController<ComposeUserPhotoViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.Title.createUser
    }
}
