//
//  CoinsAPIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Utils

public final class CoinsAPIDataManager: APIDataManager, CoinsAPIDataManagerProtocol {
    public func getCoins(currency: String,
                         page: Int,
                         pageSize: Int,
                         completion: @escaping Completion<[Coin], APIError>) {
        let endpoint = RequestDescription.Coins.getCoinsMarkets
            .replacingQueryParameters(
                .getCoinsMarkets(
                    currency: currency,
                    page: page,
                    pageSize: pageSize
                )
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getCoins,
            responseType: [CoinResponse].self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(response.map { Coin(coinResponse: $0) }))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func getCoinDetails(id: String,
                               completion: @escaping Completion<CoinDetails, APIError>) {
        let endpoint = RequestDescription.Coins.getCoinDetails
            .replacingInlineArguments(
                .id(id)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getCoinDetails,
            responseType: CoinDetailsResponse.self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(CoinDetails(coinDetailsResponse: response)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func getCoinMarketChart(id: String,
                                   currency: String,
                                   startTimeInterval: TimeInterval,
                                   endTimeInterval: TimeInterval,
                                   completion: @escaping Completion<CoinChartData, APIError>) {
        let endpoint = RequestDescription.Coins.getCoinMarketChart
            .replacingQueryParameters(
                .getCoinMarketChart(
                    currency: currency,
                    startTimeInterval: startTimeInterval,
                    endTimeInterval: endTimeInterval
                )
            )
            .replacingInlineArguments(
                .id(id)
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getCoinMarketChart,
            responseType: CoinChartDataResponse.self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(CoinChartData(coinChartDataResponse: response)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func search(query: String,
                       completion: @escaping Completion<SearchResult, APIError>) {
        let endpoint = RequestDescription.Search.search
            .replacingQueryParameters(
                .search(
                    query: query
                )
            )
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .search,
            responseType: SearchResponse.self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(SearchResult(searchResponse: response)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func getGlobalData(completion: @escaping Completion<GlobalData, APIError>) {
        let endpoint = RequestDescription.Global.getGlobalData
        
        execute(
            request: makeDataRequest(for: endpoint),
            errorCode: .getGlobalData,
            responseType: GlobalDataResponse.self,
            completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(GlobalData(globalDataResponse: response)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
}
