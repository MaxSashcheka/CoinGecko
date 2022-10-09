//
//  CoinDetailsResponse.swift
//  Core
//
//  Created by Maksim Sashcheka on 9.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public extension Closure {
    typealias CoinDetailsResponse = (Core.CoinDetailsResponse) -> Swift.Void
}

public struct CoinDetailsResponse: Decodable {
    public let id: String
    public let name: String
    public let symbol: String
    public let image: ImageResponse
    public let marketCapRank: Int
    public let marketData: CoinDetailsMarketData
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case image
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
    }
}

// TODO: - remove cording keys and use decode from snake case 

public struct ImageResponse: Decodable {
    public let thumb: URL
    public let small: URL
    public let large: URL
}

public struct CoinDetailsMarketData: Decodable {
    public let currentPrice: PriceDictionary
    
    private enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
    }
}

public struct PriceDictionary: Decodable {
    public let aed: Double
    public let ars: Double
    public let aud: Double
    public let bch: Double
    public let bdt: Double
    public let bhd: Double
    public let bmd: Double
    public let bnb: Double
    public let brl: Double
    public let btc: Double
    public let cad: Double
    public let chf: Double
    public let clp: Double
    public let cny: Double
    public let czk: Double
    public let dkk: Double
    public let dot: Double
    public let eos: Double
    public let eth: Double
    public let eur: Double
    public let gbp: Double
    public let hkd: Double
    public let huf: Double
    public let idr: Double
    public let ils: Double
    public let inr: Double
    public let jpy: Double
    public let krw: Double
    public let kwd: Double
    public let lkr: Double
    public let ltc: Double
    public let mmk: Double
    public let mxn: Double
    public let myr: Double
    public let ngn: Double
    public let nok: Double
    public let nzd: Double
    public let php: Double
    public let pkr: Double
    public let pln: Double
    public let rub: Double
    public let sar: Double
    public let sek: Double
    public let sgd: Double
    public let thb: Double
    public let `try`: Double
    public let twd: Double
    public let uah: Double
    public let usd: Double
    public let vef: Double
    public let vnd: Double
    public let xag: Double
    public let xau: Double
    public let xdr: Double
    public let xlm: Double
    public let xrp: Double
    public let yfi: Double
    public let zar: Double
    public let bits: Double
    public let link: Double
    public let sats: Double
}
