//
//  GitHubUser.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import Foundation

struct GitHubUser: Codable {
    
    let username: String
    let profileImage: String
    let followers: Int
    let following: Int
    let publicGists: Int
    let publicRepos: Int
    let bio: String?
    let location: String?
    let name: String?
    let profileURLString: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case followers, following, bio, location, name
        case username = "login"
        case profileImage = "avatar_url"
        case publicGists = "public_gists"
        case publicRepos = "public_repos"
        case profileURLString = "html_url"
        case createdAt = "created_at"
    }
}
