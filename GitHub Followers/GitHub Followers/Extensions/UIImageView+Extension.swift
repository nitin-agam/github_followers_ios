//
//  UIImageView+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 25/06/23.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage? = nil, mode: UIView.ContentMode = .scaleAspectFit, tintColor: UIColor? = nil, radius: CGFloat = 0.0) {
        
        self.init(frame: .zero)
        self.image = image
        self.contentMode = mode
        self.tintColor = tintColor
        
        if radius > 0.0 {
            layer.cornerRadius = radius
            layer.masksToBounds = true
        }
    }
}
