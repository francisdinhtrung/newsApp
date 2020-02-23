//
//  Context.swift
//  News
//
//  Created by Trung Vu on 2/5/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit

class Context {
    
    static func isAuthenticated() -> Bool {
        return getToken().count > 0
    }
    
    static func getToken() -> String {
        let defaults = UserDefaults.standard
        return defaults[.init(rawValue: Constants.KeyApp.appToken.rawValue)] ?? ""
    }
    
    static func setToken(_ token: String) {
        let defaults = UserDefaults.standard
        defaults.register(defaults: ["NewsToken": token])
    }
    
    static func getHeader(page: Int) -> [String: String] {
        var headers: [String : String] = ["Content-Type": "application/json"]
        headers["x-api-key"] = Constants.apiKey
        headers["page"] = page.toString
        headers["pageSize"] = Constants.pageSize.toString
        return headers
    }
}
