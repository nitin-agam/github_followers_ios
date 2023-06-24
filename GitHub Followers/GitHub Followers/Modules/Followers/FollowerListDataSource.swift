//
//  FollowerListDataSource.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import Foundation

class FollowerListDataSource {
    
    // MARK: - Properties
    private var allFollowers: [GitHubFollower] = []
    private var filteredFollowers: [GitHubFollower] = []
    private var pageCount = 1000
    private var pageNumber = 1
    
    
    // MARK: - Methods
    func fetchFollowers(for username: String, _ completion: (() -> ())?) {
        
        Networking.sendRequest(.followers(username: username,
                                          pageCount: pageCount,
                                          pageNumber: pageNumber)) { result in
            switch result {
            case .success(let data):
                do {
                    self.allFollowers = try JSONDecoder().decode([GitHubFollower].self, from: data)
                    self.filteredFollowers = self.allFollowers
                } catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
            completion?()
        }
    }
    
    func showOldData() {
        filteredFollowers = allFollowers
    }
    
    func numberOfItem(in section: Int) -> Int {
        filteredFollowers.count
    }
    
    func objectAt(_ indexPath: IndexPath) -> GitHubFollowerViewModel? {
        if indexPath.item < filteredFollowers.count {
            return GitHubFollowerViewModel(follower: filteredFollowers[indexPath.item])
        }
        return nil
    }
    
    func filterFollowers(searchText: String) {
        self.filteredFollowers = allFollowers.filter { $0.username.lowercased().contains(searchText.lowercased())}
    }
}
