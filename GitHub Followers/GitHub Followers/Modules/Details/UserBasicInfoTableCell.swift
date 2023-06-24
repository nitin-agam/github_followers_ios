//
//  UserBasicInfoTableCell.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import UIKit

class UserBasicInfoTableCell: BaseTableCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    var userDetail: GitHubUserViewModel? {
        didSet {
            guard let detail = userDetail else { return }
            profileImageView.sd_setImage(with: detail.imageURL,
                                  placeholderImage: UIImage(named: "icon_avatar_placeholder"))
            usernameLabel.text = detail.userName
            fullNameLabel.text = detail.fullName
            locationLabel.text = detail.location
            bioLabel.text = detail.bio
        }
    }
    
    
    override func initialSetup() {
        super.initialSetup()
        
        let verticalStack = UIStackView([usernameLabel, fullNameLabel, locationLabel], axis: .vertical, spacing: 8)
        let horizontalStack = UIStackView([profileImageView, verticalStack], axis: .horizontal, spacing: 12)
        let contentStack = UIStackView([horizontalStack, bioLabel], axis: .vertical, spacing: 15)
        
        addSubview(contentStack)
        
        contentStack.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(-20)
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(120)
        }
    }
}
