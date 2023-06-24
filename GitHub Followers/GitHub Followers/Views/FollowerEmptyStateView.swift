//
//  FollowerEmptyStateView.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import UIKit

class FollowerEmptyStateView: UIView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .secondaryLabel
        label.text = "This user doesn't have any followers 😢"
        label.numberOfLines = 0
        return label
    }()
    
    private let placeholderImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_empty_logo"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        backgroundColor = .clear
        
        addSubviews(messageLabel, placeholderImageView)
        
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(50)
        }
        
        placeholderImageView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.centerX.equalToSuperview().offset(150)
            make.centerY.equalToSuperview().offset(100)
        }
    }
}
