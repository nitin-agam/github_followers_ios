//
//  String+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import UIKit

extension String {
    
    func verticalSpacing(spacing: CGFloat = 2, alignment: NSTextAlignment = .center) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignment
        attributedString.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // <- This is the date format of the string being converted to a Date object. If the string is not in this format, the the dateFormatter.date(from: string) returns an optional with a nil value
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current // <- uses the time zone of this system
        return dateFormatter.date(from: self)
    }
}
