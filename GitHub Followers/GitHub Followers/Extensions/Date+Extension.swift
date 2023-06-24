//
//  Date+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import Foundation

extension Date {
    
    func toString() -> String {
        return self.formatted(date: .abbreviated, time: .omitted)
    }
}
