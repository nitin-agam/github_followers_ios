//
//  CAGradientLayer+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

extension CAGradientLayer {
    
    class func gradientLayer(frame: CGRect?, view: UIView?, colors: [UIColor]) -> CAGradientLayer {
        let layer = CAGradientLayer()
        if let viewFrame = frame {
            layer.frame = viewFrame
        } else if let sender = view {
            layer.frame = sender.frame
        }
        layer.colors = [UIColor.gradientFirst.cgColor, UIColor.gradientSecond.cgColor]
        return layer
    }
    
    class func buttonLayer(frame: CGRect?, button: UIButton?) -> CAGradientLayer {
        let layer = CAGradientLayer()
        if let buttonFrame = frame {
            layer.frame = buttonFrame
        } else if let sender = button {
            layer.frame = sender.frame
        }
        layer.colors = [UIColor.gradientFirst.cgColor, UIColor.gradientSecond.cgColor]
        layer.startPoint = .zero
        layer.endPoint = CGPoint(x: 1, y: 1)
        return layer
    }
    
    class func backgroundViewLayer(frame: CGRect?, view: UIView?) -> CAGradientLayer {
        let layer = CAGradientLayer()
        if let viewFrame = frame {
            layer.frame = viewFrame
        } else if let sender = view {
            layer.frame = sender.frame
        }
        layer.colors = [UIColor.gradientFirst.cgColor, UIColor.gradientSecond.cgColor]
        return layer
    }
}

