//
//  APIClient.swift
//  Core
//
//  Created by Maksim Sashcheka on 1.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Alamofire
import Utils

public class APIClient {
    private static var baseURL: String = "https://api.coingecko.com/api/v3/"
    
    // TODO: rework
    
    public static func makeDataRequest(for endpoint: RequestDescription) -> DataRequest {
        AF.request(
            baseURL + endpoint.path,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
    }
    
    public static func execute(request: DataRequest,
                               success: @escaping Closure.OptionalData,
                               failure: @escaping Closure.GeneralError) {
        request
            .validate()
            .response(completionHandler: { response in
                switch response.result {
                case let .success(data):
                    success(data)
                case let .failure(afError):
                    guard let responseData = response.data else {
                        failure(.corrutpedDataResponse)
                        return
                    }
                    // TODO: - Add decoding response error
                }
            })
            .resume()
    }
    
    public static func execute<ResultType>(request: DataRequest,
                                           success: @escaping (ResultType) -> Void,
                                           failure: @escaping Closure.GeneralError) where ResultType: APIResponse {
        execute(request: request, success: { data in
            do {
                guard let data = data else {
                    failure(.corrutpedDataResponse)
                    return
                }
                
                let result = try ResultType.make(from: data)
                success(result)
            } catch {
                // TODO: - Add custom error based on decoding error type
                failure(.corruptedResponse)
            }
        }, failure: failure)
    }
    
    public static func execute(request: DataRequest,
                               success: @escaping Closure.Void,
                               failure: @escaping Closure.GeneralError) {
        execute(request: request, success: { _ in success() }, failure: failure)
    }
}
