//
//  Constants.swift
//  News
//
//  Created by Trung Vu on 2/4/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit

struct Constants {
    
    static let apiKey = "af739f6e915844bc9cb8bf37af51d5fb"
    static let pageSize = 10
    
    enum KeyApp: String {
        case appToken = "NewsToken"
    }
    
    static func baseURL() -> String {
        #if DEBUG
            return "https://newsapi.org/v2"
        #else
            return "https://newsapi.org/v2"
        #endif
    }

}
