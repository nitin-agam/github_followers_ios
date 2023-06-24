//
//  AppTutorialTableCell.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit
import SnapKit

class AppTutorialTableCell: BaseTableCell {
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.gradientSecond
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.gradientSecond
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    var tutorial: AppTutorial? {
        didSet {
            guard let tutorial = tutorial else { return }
            titleLabel.text = tutorial.title?.uppercased()
            detailLabel.attributedText = tutorial.description?.verticalSpacing(spacing: 3, alignment: .left)
            icon.image = UIImage(systemName: tutorial.imageName ?? "")
        }
    }
    
    override func initialSetup() {
        super.initialSetup()
        
        let verticalStack = UIStackView([titleLabel, detailLabel], axis: .vertical, spacing: 8)
        let contentStack = UIStackView([icon, verticalStack], spacing: 20)
        
        addSubview(contentStack)
        
        contentStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(-30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        icon.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
        }
    }
}
