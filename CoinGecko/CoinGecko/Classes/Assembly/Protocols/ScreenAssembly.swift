//
//  ScreenAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils
import UIKit.UIViewController

protocol ScreenTransitions { }

protocol Screen: UIViewController {
    associatedtype Transitions: ScreenTransitions

    var transitions: Transitions { get set }
}

protocol ScreensAssembly: Assembly { }
