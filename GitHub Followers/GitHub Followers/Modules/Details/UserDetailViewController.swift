//
//  UserDetailViewController.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit
import SafariServices

class UserDetailViewController: UITableViewController {
    
    // MARK: - Properties
    private var username: String
    private let dataSource = UserDetailDataSource()
    
    
    // MARK: - LifeCycle
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchData()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        navigationItem.title = "Profile Detail"
        view.backgroundColor = .systemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(cellWithClass: UserBasicInfoTableCell.self)
        tableView.register(cellWithClass: UserReposInfoTableCell.self)
        tableView.register(cellWithClass: UserFollowInfoTableCell.self)
    }
    
    private func fetchData() {
        dataSource.userDetail(for: username) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func openGitHubProfile() {
        guard let profileURL = dataSource.userDetail?.profileURL else { return }
        let safariViewController = SFSafariViewController(url: profileURL)
        present(safariViewController, animated: true, completion: nil)
    }
    
    private func openGitHubFollowers() {
        let controller = FollowerListViewController(username: self.username)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension UserDetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DetailSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case DetailSections.basicInfo.rawValue:
            let cell = tableView.dequeueReusableCell(withClass: UserBasicInfoTableCell.self)
            cell.userDetail = dataSource.userDetail
            return cell
            
        case DetailSections.reposInfo.rawValue:
            let cell = tableView.dequeueReusableCell(withClass: UserReposInfoTableCell.self)
            cell.userDetail = dataSource.userDetail
            
            cell.openGitHubProfileHandler = { [weak self] in
                guard let self = self else { return }
                self.openGitHubProfile()
            }
            
            return cell
            
        case DetailSections.followInfo.rawValue:
            let cell = tableView.dequeueReusableCell(withClass: UserFollowInfoTableCell.self)
            cell.userDetail = dataSource.userDetail
            
            cell.openGitHubFollowersHandler = { [weak self] in
                guard let self = self else { return }
                self.openGitHubFollowers()
            }
            
            return cell
            
        default: return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let createdAt = dataSource.userDetail?.createdAtString else { return nil }
        
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "Joined GitHub on \(createdAt)"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .tertiaryLabel
        titleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        return headerView
    }
}
