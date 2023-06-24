//
//  NAEndpoint.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import Foundation

public typealias HTTPParameters = [String: Any]

public enum NAEndpoint {
    case followers(username: String, pageCount: Int, pageNumber: Int)
}

extension NAEndpoint {
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
}

extension NAEndpoint {
    
    var urlRequest: URLRequest? {
        switch self {
        case .followers(let username, let pageCount, let pageNumber):
            let queryItems = [NAQueryItem(key: "per_page", value: "\(pageCount)"),
                              NAQueryItem(key: "page", value: "\(pageNumber)")]
            return .make(endpoint: "users/\(username)/followers", headers: nil, queries: queryItems, method: .GET, version: nil, params: nil)
        }
    }
}

extension URLRequest {
    
    static func make(endpoint: String, headers: [NAHeaderField]?, queries: [NAQueryItem]?, method: NAEndpoint.HTTPMethod = .GET, version: Int?, params: [String: Any]? = nil) -> URLRequest? {
        
        var urlComponents = NARequestFactory.baseURLComponents(baseVersion: version)
        urlComponents.path.append(endpoint)
        
        if let queryArray = queries, queryArray.isEmpty == false {
            queryArray.forEach { (item) in
                urlComponents.queryItems?.append(URLQueryItem(name: item.key, value: item.value))
            }
        }
        
        if let url = urlComponents.url {
            var request = NARequestFactory.baseURLRequest(url: url)
            request.httpMethod = method.rawValue
            if let parameters = params {
                request.httpBody = NANetworkManager.convertToData(parameters)
            }
            
            if let headerArray = headers, headerArray.isEmpty == false {
                headerArray.forEach { (headerField) in
                    request.setValue(headerField.value, forHTTPHeaderField: headerField.key)
                }
            }
            
            return request
        }
        return nil
    }
}

struct NAQueryItem {
    let key: String
    let value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

struct NAHeaderField {
    let key: String
    let value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
