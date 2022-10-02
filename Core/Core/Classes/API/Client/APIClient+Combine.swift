//
//  APIClient+Combine.swift
//  Core
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import Utils

public extension APIClient {
    final class Combine {
        public static func getCoinsMarkets(currency: String,
                                           page: Int,
                                           pageSize: Int) -> AnyPublisher<[CoinResponse], APIError> {
                Future { promise in
                    APIClient.getCoinsMarkets(
                        currency: currency,
                        page: page,
                        pageSize: pageSize,
                        success: { promise(.success($0)) },
                        failure: { promise(.failure($0)) }
                    )
                }
                .share()
                .eraseToAnyPublisher()
        }
        
        public static func getCoinMarketChart(id: String,
                                              currency: String,
                                              startTimeInterval: TimeInterval,
                                              endTimeInterval: TimeInterval) -> AnyPublisher<CoinChartDataResponse, APIError> {
            Future { promise in
                APIClient.getCoinMarketChart(
                    id: id,
                    currency: currency,
                    startTimeInterval: startTimeInterval,
                    endTimeInterval: endTimeInterval,
                    success: { promise(.success($0)) },
                    failure: { promise(.failure($0)) }
                )
            }
            .share()
            .eraseToAnyPublisher()
        }
    }
}
