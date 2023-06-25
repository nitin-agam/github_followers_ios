//
//  UIColor+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

infix operator |: AdditionPrecedence
extension UIColor {

    static let gradientFirst = UIColor.colorWithHex(hex: "5B247A")
    static let gradientSecond = UIColor.colorWithHex(hex: "C53364")
    
    class func colorWithHex(hex: String, alpha: CGFloat? = 1.0) -> UIColor {
        var colorString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // Remove prefix if contain # at 0th position.
        if colorString.hasPrefix("#") { colorString.remove(at: colorString.startIndex) }
        if colorString.count != 6 { return UIColor.gray }
        
        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)
        
        return UIColor (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha ?? 1.0
        )
    }
}

