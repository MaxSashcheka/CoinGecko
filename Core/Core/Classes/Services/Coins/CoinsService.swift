//
//  CoinsService.swift
//  Core
//
//  Created by Maksim Sashcheka on 15.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Utils

public class CoinsService: CoinsServiceProtocol {
    private let coinsAPIDataManager: CoinsAPIDataManagerProtocol
    private let coinsCacheDataManager: CoinsCacheDataManagerProtocol
    
    public init(coinsAPIDataManager: CoinsAPIDataManagerProtocol,
                coinsCacheDataManager: CoinsCacheDataManagerProtocol) {
        self.coinsAPIDataManager = coinsAPIDataManager
        self.coinsCacheDataManager = coinsCacheDataManager
    }
    
    public func getStoredCoin(id: String,
                              completion: @escaping Completion<Coin, ServiceError>) {
        guard let coin = coinsCacheDataManager.cachedCoins[id] else {
            let appError = AppError(code: .unexpected, message: "Cached coin not found")
            completion(.failure(ServiceError(code: .getStoredCoin, underlying: appError)))
            return
        }
        completion(.success(coin))
    }
    
    // MARK: - API methods
    public func getCoins(fromCache: Bool = false,
                         currency: String, page: Int, pageSize: Int,
                         completion: @escaping Completion<[Coin], ServiceError>) {
        if fromCache {
            completion(.success(coinsCacheDataManager.cachedCoins.allItems))
            return
        }
        coinsAPIDataManager.getCoins(
            currency: currency,
            page: page,
            pageSize: pageSize,
            completion: { [weak self] result in
                switch result {
                case .success(let coins):
                    self?.coinsCacheDataManager.cachedCoins.append(contentsOf: coins)
                    completion(.success(coins))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .getCoins, underlying: error)))
                }
            }
        )
    }
    
    public func getCoinDetails(id: String,
                               completion: @escaping Completion<CoinDetails, ServiceError>) {
        coinsAPIDataManager.getCoinDetails(
            id: id,
            completion: { result in
                switch result {
                case .success(let coinDetails):
                    completion(.success(coinDetails))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .getCoinDetails, underlying: error)))
                }
            }
        )
    }
    
    public func getCoinMarketChart(id: String,
                                   currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   completion: @escaping Completion<CoinChartData, ServiceError>) {
        coinsAPIDataManager.getCoinMarketChart(
            id: id,
            currency: currency,
            startTimeInterval: startTimeInterval,
            endTimeInterval: endTimeInterval,
            completion: { result in
                switch result {
                case .success(let coinChartData):
                    completion(.success(coinChartData))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .getCoinMarketChart, underlying: error)))
                }
            }
        )
    }
    
    public func search(query: String,
                       completion: @escaping Completion<SearchResult, ServiceError>) {
        coinsAPIDataManager.search(
            query: query,
            completion: { result in
                switch result {
                case .success(let searchResult):
                    completion(.success(searchResult))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .search, underlying: error)))
                }
            }
        )
    }
    
    public func getGlobalData(completion: @escaping Completion<GlobalData, ServiceError>) {
        coinsAPIDataManager.getGlobalData(
            completion: { result in
                switch result {
                case .success(let gloabalData):
                    completion(.success(gloabalData))
                case .failure(let error):
                    completion(.failure(ServiceError(code: .getGlobalData, underlying: error)))
                }
            }
        )
    }
}
