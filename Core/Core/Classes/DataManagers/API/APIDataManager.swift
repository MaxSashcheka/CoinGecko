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
    
    private func afExecute(request: DataRequest,
                           errorCode: APIErrorCode,
                           completion: @escaping Completion<Data?, APIError>) {
        request
            .validate()
            .response(completionHandler: { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(afError):
                    guard !response.data.isNil else {
                        completion(
                            .failure(
                                APIError(
                                    code: errorCode,
                                    underlying: afError,
                                    message: "No response data"
                                )
                            )
                        )
                        return
                    }
                    completion(
                        .failure(
                            APIError(
                                code: errorCode,
                                underlying: afError,
                                message: "Unacceptable status code"
                            )
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
        completion: @escaping Completion<ResultType, APIError>
    ) where ResultType: APIResponse {
        afExecute(
            request: request,
            errorCode: errorCode,
            completion: { result in
                switch result {
                case .success(let data):
                    do {
                        guard let data = data else {
                            completion(
                                .failure(APIError(code: errorCode, message: "No response data"))
                            )
                            return
                        }

                        let result = try ResultType.make(from: data)
                        completion(.success(result))
                    } catch {
                        completion(
                            .failure(
                                APIError(
                                    code: errorCode,
                                    underlying: error,
                                    message: "Not convertable from \(responseType.self) to \(ResultType.self)"
                                )
                            )
                        )
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    public func execute(request: DataRequest,
                        errorCode: APIErrorCode,
                        completion: @escaping Completion<Void, APIError>) {
        afExecute(
            request: request,
            errorCode: errorCode,
            completion: { result in
                switch result {
                case .success(_):
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
