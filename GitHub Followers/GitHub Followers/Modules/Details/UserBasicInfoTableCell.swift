//
//  UserBasicInfoTableCell.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import UIKit

class UserBasicInfoTableCell: BaseTableCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(mode: .scaleAspectFill, tintColor: nil, radius: 8)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel = UILabel(text: nil, font: .systemFont(ofSize: 22, weight: .semibold))
    private let fullNameLabel = UILabel(text: nil, textColor: .secondaryLabel, font: .systemFont(ofSize: 18))
    private let locationLabel = UILabel(text: nil, textColor: .secondaryLabel, font: .systemFont(ofSize: 18))
    private let bioLabel = UILabel(text: nil, lines: 0, font: .systemFont(ofSize: 20))
    
    
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
