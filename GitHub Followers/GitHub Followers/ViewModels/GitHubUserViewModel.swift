//
//  GitHubUserViewModel.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import Foundation

struct GitHubUserViewModel {
    
    private let user: GitHubUser
    
    init(user: GitHubUser) {
        self.user = user
    }
    
    var imageURL: URL? { URL(string: user.profileImage) }
    var userName: String { user.username }
    var fullName: String { user.name ?? "N/A" }
    var bio: String { user.bio ?? "N/A" }
    var location: String { user.location ?? "N/A" }
    var publicRepoCount: String { user.publicRepos.formatWithAbbreviations }
    var publicGistsCount: String { user.publicGists.formatWithAbbreviations }
    var following: String { user.following.formatWithAbbreviations }
    var followers: String { user.followers.formatWithAbbreviations }
    var createdAtString: String { user.createdAt.toDate()?.toString() ?? "N/A" }
    var profileURL: URL? { URL(string: user.profileURLString) }
}
