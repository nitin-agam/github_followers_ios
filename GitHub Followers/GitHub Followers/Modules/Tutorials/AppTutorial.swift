//
//  AppTutorial.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import Foundation

struct AppTutorial {
    
    let title: String?
    let description: String?
    let imageName: String?
    
    static var tutorials: [AppTutorial] = {
        return [AppTutorial(title: "Search User", description: "Explore the follower list by username of a GitHub user.", imageName: "magnifyingglass.circle"),
                AppTutorial(title: "Follower List", description: "See all the followers at single place with filter capability.", imageName: "person.2.circle"),
                AppTutorial(title: "Filter List", description: "You can filter out the follower list based on their usernames.", imageName: "paperclip.circle"),
                AppTutorial(title: "User Details", description: "A detailed screen to see the amazing profile.", imageName: "books.vertical.circle"),
                AppTutorial(title: "Quick Access", description: "You can access user's public profile quickly on a single click.", imageName: "bookmark.circle")]
    }()
}
