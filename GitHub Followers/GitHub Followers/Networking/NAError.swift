//
//  NAError.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 23/06/23.
//

import Foundation

final class NAError: Error {
    
    var title: String
    var description: String?
    var errorCode: String?
    
    init(title: String, desc: String? = nil, _ code: String? = nil) {
        self.title = title
        self.description = desc
        self.errorCode = code
    }
}
