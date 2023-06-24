//
//  NARequestFactory.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

public class NARequestFactory {
    
    static func baseURLComponents(baseVersion: Int?) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = NANetworkKeys.scheme
        urlComponents.host = NANetworkKeys.baseHostName
        urlComponents.path = NANetworkKeys.basePath(version: baseVersion)
        urlComponents.queryItems = []
        return urlComponents
    }
    
    static func baseURLRequest(url: URL) -> URLRequest {
        var request = baseRequest(url: url)
        request.addValue("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", forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func baseRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
