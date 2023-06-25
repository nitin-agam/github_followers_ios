//
//  AppTutorialTableCell.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit
import SnapKit

class AppTutorialTableCell: BaseTableCell {
    
    private let icon = UIImageView(tintColor: .gradientSecond)
    private let titleLabel = UILabel(text: nil, textColor: .gradientSecond, font: .systemFont(ofSize: 20, weight: .semibold))
    private let detailLabel = UILabel(text: nil, lines: 0, textColor: .label, font: .systemFont(ofSize: 18))
    
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
            make.bottom.right.equalTo(-30)
            make.left.equalTo(30)
        }
        
        icon.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
        }
    }
}
