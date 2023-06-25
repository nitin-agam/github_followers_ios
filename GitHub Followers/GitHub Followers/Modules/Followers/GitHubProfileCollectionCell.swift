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
        let imageView = UIImageView(mode: .scaleAspectFill, tintColor: nil)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel = UILabel(text: nil, alignment: .center, font: .systemFont(ofSize: 16, weight: .semibold))
    
    
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
        profileImageView.image = nil
        usernameLabel.text = nil
    }
}
