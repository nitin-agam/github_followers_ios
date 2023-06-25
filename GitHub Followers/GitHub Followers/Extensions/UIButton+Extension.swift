//
//  UIButton+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 25/06/23.
//

import UIKit

extension UIButton {
    
    convenience init(title: String?, font: UIFont?, titleColor: UIColor?, shouldRounded: Bool = false) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
    
        if shouldRounded {
            layer.cornerRadius = LayoutConstant.defaultCornerRadius
            layer.masksToBounds = true
        }
    }
}
