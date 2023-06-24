//
//  GitHubFollowerViewModel.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import Foundation

struct GitHubFollowerViewModel {
    
    private let follower: GitHubFollower
    
    init(follower: GitHubFollower) {
        self.follower = follower
    }
    
    var imageURL: URL? {
        URL(string: follower.profileImage)
    }
    
    var followerUserName: String {
        follower.username
    }
}
