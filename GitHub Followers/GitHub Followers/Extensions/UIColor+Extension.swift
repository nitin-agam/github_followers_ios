//
//  UIColor+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

infix operator |: AdditionPrecedence
extension UIColor {
    
    struct App {
//        static var toast = UIColor.colorWithHex(hex: "f2f2f2") | UIColor.colorWithHex(hex: "4d4d4d")
//        static var controllerBackground = UIColor.white | UIColor.colorWithHex(hex: "18191A")
    }
    

    // MARK: - Properties
//    static let grayBackground = UIColor(white: 0, alpha: 0.05)
//    static let cellBack = UIColor(white: 0, alpha: 0.05)
//    static let lightGreenCellBackground = UIColor(red: 220, green: 247, blue: 200)
    static let gradientFirst = UIColor.colorWithHex(hex: "5B247A")
    static let gradientSecond = UIColor.colorWithHex(hex: "C53364")
//    static let kOutlineStroke = UIColor(red: 234, green: 46, blue: 111)
//    static let kTrackStroke = UIColor(red: 56, green: 25, blue: 49)
//    static let kPulsingFill = UIColor(red: 86, green: 30, blue: 63)
//    static let kDarkBack = UIColor(red: 10, green: 35, blue: 66)
//    static let kHeader = UIColor(white: 0.2, alpha: 1)
//    static let kEmptyScreen = UIColor.colorWithHex(hex: "F1F2F6")
    
    
    // MARK: - Initialisers
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    
    // MARK: - Methods
    static func | (lightMode: UIColor, darkMode: UIColor) -> UIColor {
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
    
  
    
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

