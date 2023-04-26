//
//  APIResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public protocol APIResponse {
    static func make(from data: Data) throws -> Self
}

extension APIResponse where Self: Decodable {
    public static func make(from data: Data) throws -> Self {
        try APIHelpers.jsonDecoder.decode(Self.self, from: data)
    }
}

extension CoinsMarketResponse: APIResponse { }
extension CoinResponse: APIResponse { }
extension CoinDetailsResponse: APIResponse { }
extension CoinChartDataResponse: APIResponse { }
extension GlobalDataResponse: APIResponse { }
extension SearchResponse: APIResponse { }
extension UserResponse: APIResponse { }
extension PostResponse: APIResponse { }
extension WalletResponse: APIResponse { }
extension Array: APIResponse where Element: APIResponse, Element: Decodable { }
