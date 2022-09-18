//
//  CoinsAPIDataManagerProtocol.swift
//  Core
//
//  Created by Maksim Sashcheka on 18.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public protocol CoinsAPIDataManagerProtocol {
    func getCoins(currency: String,
                  page: Int,
                  pageSize: Int,
                  success: @escaping ([Coin]) -> Void,
                  failure: @escaping NetworkRouterErrorClosure)
}
