//
//  NetworkRouter.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

public enum NetworkRouterError: String, Error {
    case noInternetConnection = "Please check your internet connection"
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
    case unableToBuildRequest = "Error during building url request"
}

public typealias NetworkRouterErrorClosure = (NetworkRouterError) -> Void

class NetworkRouter<EndPoint: EndPointType>: NetworkRouterProtocol {
    private var task: URLSessionTask?
    
    func request<ResponseType: Decodable>(_ route: EndPoint,
                                          success: @escaping (ResponseType) -> Void,
                                          failure: @escaping NetworkRouterErrorClosure) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                if !error.isNil {
                    failure(.noInternetConnection); return
                }
                
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 401...500: failure(.authenticationError); return
                    case 501...599: failure(.badRequest); return
                    case 600: failure(.outdated); return
                    default: break
                    }
                }
                
                guard let responseData = data else {
                    failure(.noData); return
                }
                
                do {
                    let response = try JSONDecoder().decode(ResponseType.self, from: responseData)
                    success(response)
                } catch {
                    failure(.unableToDecode)
                }
            })
        } catch {
            failure(.unableToBuildRequest); return
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}

// MARK: - NetworkRouter+BuildRequest
private extension NetworkRouter {
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters,
                                        request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters,
                                        request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureParameters(bodyParameters: Parameters?,
                             urlParameters: Parameters?,
                             request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
