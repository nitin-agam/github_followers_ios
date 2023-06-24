//
//  UserDetailDataSource.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import Foundation

public enum DetailSections: Int, CaseIterable {
    case basicInfo = 0
    case reposInfo = 1
    case followInfo = 2
}

class UserDetailDataSource {
    
    // MARK: - Properties
    private(set) var userDetail: GitHubUserViewModel?
    
    
    // MARK: - Methods
    func userDetail(for username: String, _ completion: (() -> ())?) {
        Networking.sendRequest(.userDetail(username: username)) { result in
            switch result {
            case .success(let data):
                do {
                    let gitHubUser = try JSONDecoder().decode(GitHubUser.self, from: data)
                    self.userDetail = GitHubUserViewModel(user: gitHubUser)
                } catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
            completion?()
        }
    }
}
