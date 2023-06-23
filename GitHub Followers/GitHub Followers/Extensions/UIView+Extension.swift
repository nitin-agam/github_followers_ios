//
//  UIView+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0) }
    }
    
    func makeGradient(frame: CGRect?) {
        var gradientLayer: CAGradientLayer
        switch self {
        case is UIButton:
            gradientLayer = CAGradientLayer.buttonLayer(frame: frame, button: self as? UIButton)
            
        default:
            gradientLayer = CAGradientLayer.backgroundViewLayer(frame: frame, view: self)
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
