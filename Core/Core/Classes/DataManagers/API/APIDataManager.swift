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
                        errorCode: APIErrorCode,
                        success: @escaping Closure.OptionalData,
                        failure: @escaping Closure.APIError) {
        request
            .validate()
            .response(completionHandler: { response in
                switch response.result {
                case let .success(data):
                    success(data)
                case let .failure(afError):
                    guard !response.data.isNil else {
                        failure(
                            APIError(
                                code: errorCode,
                                underlying: afError,
                                message: "No response data"
                            )
                        )
                        return
                    }
                    failure(
                        APIError(
                            code: errorCode,
                            underlying: afError,
                            message: "Unacceptable status code"
                        )
                    )
                }
            })
            .resume()
    }
    
    public func execute<ResultType>(
        request: DataRequest,
        errorCode: APIErrorCode,
        responseType: ResultType.Type,
        success: @escaping (ResultType) -> Void,
        failure: @escaping Closure.APIError
    ) where ResultType: APIResponse {
        execute(request: request, errorCode: errorCode, success: { data in
            do {
                guard let data = data else {
                    failure(
                        APIError(code: errorCode, message: "No response data")
                    )
                    return
                }

                let result = try ResultType.make(from: data)
                success(result)
            } catch {
                failure(
                    APIError(
                        code: errorCode,
                        underlying: error,
                        message: "Not convertable from \(responseType.self) to \(ResultType.self)"
                    )
                )
            }
        }, failure: failure)
    }
    
    public func execute(request: DataRequest,
                        errorCode: APIErrorCode,
                        success: @escaping Closure.Void,
                        failure: @escaping Closure.APIError) {
        execute(
            request: request,
            errorCode: errorCode,
            success: { _ in success() },
            failure: failure
        )
    }
}
