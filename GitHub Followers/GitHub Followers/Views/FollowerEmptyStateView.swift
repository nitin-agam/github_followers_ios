//
//  FollowerEmptyStateView.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import UIKit

class FollowerEmptyStateView: UIView {
    
    private let messageLabel = UILabel(text: "This user doesn't have any followers 😢", lines: 0, alignment: .center, textColor: .secondaryLabel, font: .systemFont(ofSize: 30, weight: .medium))
    private let placeholderImageView = UIImageView(image: UIImage(named: "icon_empty_logo"), mode: .scaleAspectFill)
    
    
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
