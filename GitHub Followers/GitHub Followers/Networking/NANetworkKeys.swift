//
//  NANetworkKeys.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

struct NANetworkKeys {
    
    static var hostName: String {
        get {
            if NANetworkKeys.environment == .staging {
                return "api"
            } else {
                return "api"
            }
        }
    }
    
    static var environment: Env {
        return .prod
    }
    
    static func basePath(version: Int?) -> String {
        guard let value = version else {
            return "/"
        }
        return "/v\(value)/"
    }
    
    enum Env: String {
        case staging
        case prod
    }
    
    static let scheme = "https"
    static let baseHostName = "\(hostName).github.com"
    static let defaultAppEnvironment = Env.prod
}


