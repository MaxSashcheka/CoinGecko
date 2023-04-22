//
//  APIDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 16.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import Alamofire
import Utils

public class APIDataManager {
//    private var baseURL: String = ""
    
    public init() { }
    
    public func makeDataRequest(for endpoint: RequestDescription) -> DataRequest {
        AF.request(
            endpoint.path,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
    }
    
    public func execute(request: DataRequest,
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
                    failure(.unacceptableStatusCode)
                    // TODO: - Add decoding response error
                }
            })
            .resume()
    }
    
    public func execute<ResultType>(
        request: DataRequest,
        responseType: ResultType.Type,
        success: @escaping (ResultType) -> Void,
        failure: @escaping Closure.GeneralError
    ) where ResultType: APIResponse {
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
    
    public func execute(request: DataRequest,
                        success: @escaping Closure.Void,
                        failure: @escaping Closure.GeneralError) {
        execute(request: request, success: { _ in success() }, failure: failure)
    }
}
