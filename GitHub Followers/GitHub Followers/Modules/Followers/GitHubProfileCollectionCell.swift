//
//  GitHubProfileCollectionCell.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit
import SDWebImage

class GitHubProfileCollectionCell: BaseCollectionCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        backgroundColor = UIColor.tertiarySystemGroupedBackground
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubviews(profileImageView, usernameLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(self.snp.width)
            make.top.centerX.equalToSuperview()
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
        }
    }
    
    func configure(with viewModel: GitHubFollowerViewModel?) {
        guard let follower = viewModel else { return }
        profileImageView.sd_setImage(with: follower.imageURL,
                              placeholderImage: UIImage(named: "icon_avatar_placeholder"))
        usernameLabel.text = viewModel?.followerUserName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.profileImageView.image = nil
    }
}
