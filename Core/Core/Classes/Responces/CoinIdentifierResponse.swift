//
//  CoinIdentifierResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 27.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public struct CoinIdentifierResponse: Decodable {
    public let id: String
    public let walletId: String
    public let identifier: String
}
