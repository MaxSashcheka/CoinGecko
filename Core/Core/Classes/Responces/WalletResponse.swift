//
//  WalletResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Foundation

public struct WalletResponse: Decodable {
    public let id: String
    public let userId: String
    public let name: String
    public let colorHex: String
}
