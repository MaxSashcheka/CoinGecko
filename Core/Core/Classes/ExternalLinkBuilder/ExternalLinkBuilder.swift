//
//  ExternalLinkBuilder.swift
//  Core
//
//  Created by Maksim Sashcheka on 7.12.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Foundation

public struct ExternalLinkBuilder {
    let webURL: String
    
    public init(webURL: String) {
        self.webURL = webURL
    }
    
    public func buildGoogleSearchURL(query: String) -> URL? {
        let urlString = webURL + Page.search
        var urlComponents = URLComponents(string: urlString)
        
        urlComponents?.queryItems = [URLQueryItem(name: QueryItems.Query.key, value: query)]

        return URL(string: urlComponents?.string ?? .empty)
    }
}

// MARK: - Constants
extension ExternalLinkBuilder {
    enum Page {
        static let search = "/search"
    }
    enum QueryItems {
        enum Query {
            static let key: String = "q"
        }
    }
}
