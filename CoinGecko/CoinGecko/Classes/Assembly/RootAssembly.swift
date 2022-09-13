//
//  RootAssembly.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

final class RootAssembly: Assembly {
    static func makeRootCoordinator() -> RootCoordinator { RootCoordinator(parent: nil) }
}
