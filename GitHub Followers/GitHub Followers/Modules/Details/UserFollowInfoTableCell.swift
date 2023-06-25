//
//  UserFollowInfoTableCell.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import UIKit

class UserFollowInfoTableCell: BaseTableCell {
    
    private let followingValueLabel = UILabel(text: "0", font: .systemFont(ofSize: 24, weight: .semibold))
    private let followersValueLabel = UILabel(text: "0", font: .systemFont(ofSize: 24, weight: .semibold))
    
    private lazy var submitButton: UIButton = {
        let button = UIButton(title: "Get Followers", font: .systemFont(ofSize: 18, weight: .semibold), titleColor: .white, shouldRounded: true)
        button.addTarget(self, action: #selector(handleSubmitTapped), for: .touchUpInside)
        return button
    }()
    
    var userDetail: GitHubUserViewModel? {
        didSet {
            guard let detail = userDetail else { return }
            followingValueLabel.text = detail.following
            followersValueLabel.text = detail.followers
        }
    }

    var openGitHubFollowersHandler: (() -> ())?

    
    override func initialSetup() {
        super.initialSetup()
        
        let followingStackView = buildMetaStackView(with: followingValueLabel,
                                                      systemIcon: "bolt.heart",
                                                      title: "Following")
        
        let followersStackView = buildMetaStackView(with: followersValueLabel,
                                                      systemIcon: "person.2",
                                                      title: "Followers")
        
        let horizontalContentStack = UIStackView([followingStackView, followersStackView],
                                                 axis: .horizontal,
                                                 spacing: 12,
                                                 distribution: .fillEqually,
                                                 alignment: .top)
        
        let verticalStack = UIStackView([horizontalContentStack, submitButton],
                                        axis: .vertical,
                                        spacing: 25,
                                        distribution: .fillEqually,
                                        alignment: .fill)
        
        verticalStack.layoutMargins = .init(top: 15, left: 20, bottom: 15, right: 20)
        verticalStack.isLayoutMarginsRelativeArrangement = true
        verticalStack.addBackgroundColor(.tertiarySystemGroupedBackground)
        verticalStack.layer.cornerRadius = LayoutConstant.defaultCornerRadius
        verticalStack.layer.masksToBounds = true
        
        contentView.addSubview(verticalStack)
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-15)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.height.equalTo(LayoutConstant.defaultHeight)
        }
        
        submitButton.makeGradient(frame: CGRect(x: 0,
                                                   y: 0,
                                                width: UIScreen.main.bounds.width - 80,
                                                   height: LayoutConstant.defaultHeight))
    }
    
    private func buildMetaStackView(with valueLabel: UILabel, systemIcon: String, title: String, value: Int = 0) -> UIStackView {
        let imageView = UIImageView(image: UIImage(systemName: systemIcon)?.withRenderingMode(.alwaysTemplate), tintColor: .secondaryLabel)
        let titleLabel = UILabel(text: title, textColor: .secondaryLabel, font: .systemFont(ofSize: 18))
        let horizontalStack = UIStackView([imageView, titleLabel], axis: .horizontal, spacing: 12)
        let verticalStack = UIStackView([horizontalStack, valueLabel], axis: .vertical, spacing: 12, alignment: .center)
        return verticalStack
    }
    
    @objc private func handleSubmitTapped() {
        openGitHubFollowersHandler?()
    }
}
