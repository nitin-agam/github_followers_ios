//
//  GitHubFollower.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import Foundation

struct GitHubFollower: Codable {
    
    let username: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case profileImage = "avatar_url"
    }
}
