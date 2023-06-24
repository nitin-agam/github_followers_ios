//
//  UserReposInfoTableCell.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import UIKit

class UserReposInfoTableCell: BaseTableCell {
    
    private let publicReposValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .label
        label.text = "0"
        return label
    }()
    
    private let publicGistsValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .label
        label.text = "0"
        return label
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = LayoutConstant.defaultCornerRadius
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleSubmitTapped), for: .touchUpInside)
        button.setTitle("GitHub Profile", for: .normal)
        return button
    }()
    
    var userDetail: GitHubUserViewModel? {
        didSet {
            guard let detail = userDetail else { return }
            publicReposValueLabel.text = detail.publicRepoCount
            publicGistsValueLabel.text = detail.publicGistsCount
        }
    }
    
    var openGitHubProfileHandler: (() -> ())?

    override func initialSetup() {
        super.initialSetup()
        
        let publicReposStackView = buildMetaStackView(with: publicReposValueLabel,
                                                      systemIcon: "folder",
                                                      title: "Public Repos")
        
        let publicGistsStackView = buildMetaStackView(with: publicGistsValueLabel,
                                                      systemIcon: "list.bullet.rectangle",
                                                      title: "Public Gists")
        
        let horizontalContentStack = UIStackView([publicReposStackView, publicGistsStackView],
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
        let imageView = UIImageView(image: UIImage(systemName: systemIcon)?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = .systemFont(ofSize: 18)
        
        let horizontalStack = UIStackView([imageView, titleLabel], axis: .horizontal, spacing: 12)
        let verticalStack = UIStackView([horizontalStack, valueLabel], axis: .vertical, spacing: 12, alignment: .center)
        return verticalStack
    }
    
    @objc private func handleSubmitTapped() {
        openGitHubProfileHandler?()
    }
}
