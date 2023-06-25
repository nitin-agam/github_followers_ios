//
//  UILabel+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 25/06/23.
//

import UIKit

extension UILabel {
    
    convenience init(text: String?, lines: Int = 1, alignment: NSTextAlignment = .left, textColor: UIColor = .label, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.numberOfLines = lines
        self.textAlignment = alignment
        self.textColor = textColor
        self.font = font
    }
}
