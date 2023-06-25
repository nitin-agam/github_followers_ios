//
//  UserDefault+Extension.swift
//  GitHub Followers
//
//  Created by Nitin Aggarwal on 24/06/23.
//

import UIKit

extension UserDefaults {
    struct Keys {
        static let tutorialShown = "tutorialShown"
    }
}

extension UserDefaults {
    
    subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    var tutorialShown: Bool {
        set {
            self.set(newValue, forKey: UserDefaults.Keys.tutorialShown)
        }
        get {
            return self.bool(forKey: UserDefaults.Keys.tutorialShown)
        }
    }
}
