//
//  ScreenTransitionable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.02.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Utils

protocol ScreenTransitions { }

protocol ScreenTransitionable {
    associatedtype Transitions: ScreenTransitions

    var transitions: Transitions { get }
}

typealias Transition = Closure.Void
