//
//  UserProfile.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import RealmSwift

class UserProfile: Object {
    @objc dynamic var Id = UUID().uuidString
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    @objc dynamic var createdDate: Date?
    @objc dynamic var password: String?
    @objc dynamic var modifiedDate: Date = Date()
    public override static func primaryKey() -> String? { return "email" }
    
    static func build() -> UserProfile {
        let userProfile = UserProfile()
        return userProfile
    }
    
    func setEmail(_ email: String) -> UserProfile {
        self.email = email
        return self
    }
    
    func setPhone(_ phone: String) -> UserProfile {
        self.phone = phone
        return self
    }
    
    func setCreateDate() -> UserProfile{
        self.createdDate = Date()
        return self
    }
    
    func setPassword(_ password: String) -> UserProfile {
        // should be encrypt password
        self.password = password
        return self
    }
    
}
