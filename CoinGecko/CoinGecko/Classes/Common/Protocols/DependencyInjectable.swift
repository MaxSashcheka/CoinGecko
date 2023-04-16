//
//  DependencyInjectable.swift
//  CoinGecko
//
//  Created by Maksim Sashcheka on 28.02.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

protocol DependencyInjectable: AnyObject {
    static func inject(from resolver: DependencyResolver) -> Self
}
