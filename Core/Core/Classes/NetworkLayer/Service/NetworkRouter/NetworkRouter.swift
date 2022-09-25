//
//  NetworkRouter.swift
//  Core
//
//  Created by Maksim Sashcheka on 17.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Utils

class NetworkRouter<EndPoint: EndPointType>: NetworkRouterProtocol {
    private var task: URLSessionTask?
    private let session = URLSession.shared
    
    func request<ResponseType: Decodable>(_ route: EndPoint,
                                          success: @escaping (ResponseType) -> Void,
                                          failure: @escaping NetworkRouterErrorClosure) {
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.main.async {
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
                        if let decodingError = error as? DecodingError {
                            // TODO: - Add custom errors for decoding error
                            switch decodingError {
                            case .typeMismatch(let key, let value):
                                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                            case .valueNotFound(let key, let value):
                                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                            case .keyNotFound(let key, let value):
                                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                            case .dataCorrupted(let key):
                                print("error \(key), and ERROR: \(error.localizedDescription)")
                            default:
                                print("ERROR: \(error.localizedDescription)")
                            }
                        }
                        
                        failure(.unableToDecode); return
                    }
                }
                
            })
        } catch {
            DispatchQueue.main.async {
                failure(.unableToBuildRequest); return
            }
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
            case .requestParameters(let bodyParameters, let urlParameters, let pathParameters):
                try configureParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters,
                                        pathParameters: pathParameters,
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
    
    func configureParameters(bodyParameters: Parameters? = nil,
                             urlParameters: Parameters? = nil,
                             pathParameters: [String: String]? = nil,
                             request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
            if let pathParameters = pathParameters {
                try PathParameterEncoder.encode(urlRequest: &request, with: pathParameters)
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
    
    func addPathParameters(_ pathParameters: [String : String], forPath path: String) -> String {
        pathParameters.reduce(path, { path, queryElement in
            path.replacingOccurrences(
                of: "{" + queryElement.key + "}",
                with: queryElement.value,
                options: .literal
            )
        })
    }
}
